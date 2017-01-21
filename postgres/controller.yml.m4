define(`CONTAINER_NAME', ifelse(CONTAINER_NAME, `', `postgres-9.5', CONTAINER_NAME))
define(`NAME', ifelse(PROFILE, `',
                 SERVICE-CONTROLLER_TAG,
                 SERVICE-PROFILE-CONTROLLER_TAG))
kind: ReplicationController
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: 1 # Do NOT replicate this controller -RS
  selector:
    name: NAME
    role: SERVICE
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
      annotations:
        pod.beta.kubernetes.io/subdomain: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
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
          livenessProbe:
            exec:
              command: ["sh", "-c", "pg_isready -U $POSTGRES_USER"]
            initialDelaySeconds: 5
            periodSeconds: 15
            timeoutSeconds: 5
          readinessProbe:
            exec:
              command: ["sh", "-c", "pg_isready -U $POSTGRES_USER"]
      volumes:
        - name: SERVICE-volume
          hostPath:
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
