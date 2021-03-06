define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: 1 # Do NOT replicate this controller -RS
  serviceName: SERVICE
  selector:
    matchLabels:
      role: SERVICE
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 3306
          env: 
            - name: `MYSQL_ROOT_PASSWORD' # Superuser password
              value: "MYSQL_ROOT_PASSWORD"
            - name: `MYSQL_BACKUP_S3CFG'
              value: "/etc/service/mysql/secret/s3cfg"
            - name: `MYSQL_BACKUP_S3_PREFIX'
              value: "MYSQL_BACKUP_S3_PREFIX"
          volumeMounts:
            - name: SERVICE-secret
              mountPath: /etc/service/mysql/secret
              readOnly: true
            - name: SERVICE-volume
              mountPath: /var/lib/mysql
      volumes:
        - name: SERVICE-secret
          secret:
            secretName: SERVICE
        - name: SERVICE-volume
          hostPath:
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
