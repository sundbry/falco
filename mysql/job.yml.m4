define(`CONTAINER_NAME', ifelse(CONTAINER_NAME, `', `mysql', CONTAINER_NAME))
define(`NAME', ifelse(PROFILE, `',
                 SERVICE-CONTROLLER_TAG,
                 SERVICE-PROFILE-CONTROLLER_TAG))
kind: Job
apiVersion: batch/v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  template:
    metadata:
      labels:
        name: NAME
      annotations:
        pod.beta.kubernetes.io/subdomain: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: REPOSITORY/CONTAINER_NAME:CONTAINER_TAG
          ports:
            - containerPort: 3306
          env: 
            - name: `MYSQL_ROOT_PASSWORD' # Superuser password
              value: "MYSQL_ROOT_PASSWORD"
          volumeMounts:
            - name: SERVICE-volume
              mountPath: /var/lib/mysql
          command: ["/etc/service/mysql/run", ARGUMENTS]
      volumes:
        - name: SERVICE-volume
          hostPath:
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      restartPolicy: Never
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
