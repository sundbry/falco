define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: 1
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
          image: mautic/mautic:CONTAINER_TAG
          ports:
            - containerPort: 80
          env: 
            - name: `MAUTIC_DB_HOST'
              value: "MAUTIC_DB_HOST"
            - name: `MAUTIC_DB_USER'
              value: "MAUTIC_DB_USER"
            - name: `MAUTIC_DB_PASSWORD'
              value: "MAUTIC_DB_PASSWORD"
            - name: `MAUTIC_DB_NAME'
              value: "MAUTIC_DB_NAME"
            - name: `MAUTIC_RUN_CRON_JOBS'
              value: "true"
          volumeMounts:
            - name: data
              mountPath: /var/www/html
      volumes:
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
