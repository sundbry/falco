define(`CONTAINER_NAME', ifelse(CONTAINER_NAME, `', `postgres-9.5', CONTAINER_NAME))
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
            - containerPort: 5432 # Postgres
          env: 
            - name: PGDATA
              value: /var/lib/postgresql/data/pgdata
            - name: `POSTGRES_USER' # Superuser
              value: postgres
            - name: `POSTGRES_PASSWORD' # Superuser password
              value: "POSTGRES_PASSWORD"
            - name: `WALE_S3_PREFIX'
              value: WALE_S3_PREFIX
            - name: `WALE_S3_ENDPOINT'
              value: WALE_S3_ENDPOINT
            - name: `AWS_ACCESS_KEY_ID'
              value: AWS_ACCESS_KEY_ID
            - name: `AWS_SECRET_ACCESS_KEY'
              value: AWS_SECRET_ACCESS_KEY
          volumeMounts:
            - name: SERVICE-volume
              mountPath: /var/lib/postgresql/data
          command: ["/etc/service/postgres/run", ARGUMENTS]
      volumes:
        - name: SERVICE-volume
          hostPath:
            path: HOST_VOLUME_PATH
      restartPolicy: Never
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
