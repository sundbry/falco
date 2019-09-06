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
          image: IMAGE
          ports:
            - containerPort: 9000
          env: 
            - name: `SENTRY_SECRET_KEY' 
              value: "SENTRY_SECRET_KEY"
            - name: `SENTRY_POSTGRES_HOST' 
              value: "SENTRY_POSTGRES_HOST"
            - name: `SENTRY_DB_NAME' 
              value: "SENTRY_DB_NAME"
            - name: `SENTRY_DB_USER' 
              value: "SENTRY_DB_USER"
            - name: `SENTRY_DB_PASSWORD' 
              value: "SENTRY_DB_PASSWORD"
            - name: `SENTRY_REDIS_HOST' 
              value: "SENTRY_REDIS_HOST"
            - name: `SENTRY_REDIS_PORT' 
              value: "SENTRY_REDIS_PORT"
            - name: `SENTRY_MEMCACHED_HOST' 
              value: "SENTRY_MEMCACHED_HOST"
            - name: `SENTRY_MEMCACHED_PORT' 
              value: "SENTRY_MEMCACHED_PORT"
            - name: `SENTRY_SERVER_EMAIL' 
              value: "SENTRY_SERVER_EMAIL"
            - name: `SENTRY_EMAIL_HOST' 
              value: "SENTRY_EMAIL_HOST"
            - name: `SENTRY_EMAIL_PORT' 
              value: "SENTRY_EMAIL_PORT"
            - name: `SENTRY_EMAIL_USER' 
              value: "SENTRY_EMAIL_USER"
            - name: `SENTRY_EMAIL_PASSWORD' 
              value: "SENTRY_EMAIL_PASSWORD"
            - name: `SENTRY_EMAIL_USE_TLS' 
              value: "SENTRY_EMAIL_USE_TLS"
            - name: `SENTRY_SINGLE_ORGANIZATION' 
              value: "SENTRY_SINGLE_ORGANIZATION"
          volumeMounts:
            - name: files
              mountPath: /var/lib/sentry/files

        - name: SERVICE-cron
          image: IMAGE
          command: 
            - gosu
            - sentry
            - sentry
            - run
            - cron
          env: 
            - name: `SENTRY_SECRET_KEY' 
              value: "SENTRY_SECRET_KEY"
            - name: `SENTRY_POSTGRES_HOST' 
              value: "SENTRY_POSTGRES_HOST"
            - name: `SENTRY_DB_NAME' 
              value: "SENTRY_DB_NAME"
            - name: `SENTRY_DB_USER' 
              value: "SENTRY_DB_USER"
            - name: `SENTRY_DB_PASSWORD' 
              value: "SENTRY_DB_PASSWORD"
            - name: `SENTRY_REDIS_HOST' 
              value: "SENTRY_REDIS_HOST"
            - name: `SENTRY_REDIS_PORT' 
              value: "SENTRY_REDIS_PORT"
            - name: `SENTRY_MEMCACHED_HOST' 
              value: "SENTRY_MEMCACHED_HOST"
            - name: `SENTRY_MEMCACHED_PORT' 
              value: "SENTRY_MEMCACHED_PORT"
            - name: `SENTRY_SERVER_EMAIL' 
              value: "SENTRY_SERVER_EMAIL"
            - name: `SENTRY_EMAIL_HOST' 
              value: "SENTRY_EMAIL_HOST"
            - name: `SENTRY_EMAIL_PORT' 
              value: "SENTRY_EMAIL_PORT"
            - name: `SENTRY_EMAIL_USER' 
              value: "SENTRY_EMAIL_USER"
            - name: `SENTRY_EMAIL_PASSWORD' 
              value: "SENTRY_EMAIL_PASSWORD"
            - name: `SENTRY_EMAIL_USE_TLS' 
              value: "SENTRY_EMAIL_USE_TLS"
            - name: `SENTRY_SINGLE_ORGANIZATION' 
              value: "SENTRY_SINGLE_ORGANIZATION"

        - name: SERVICE-worker-0
          image: IMAGE
          command: 
            - gosu
            - sentry
            - sentry
            - run
            - worker
          env: 
            - name: `SENTRY_SECRET_KEY' 
              value: "SENTRY_SECRET_KEY"
            - name: `SENTRY_POSTGRES_HOST' 
              value: "SENTRY_POSTGRES_HOST"
            - name: `SENTRY_DB_NAME' 
              value: "SENTRY_DB_NAME"
            - name: `SENTRY_DB_USER' 
              value: "SENTRY_DB_USER"
            - name: `SENTRY_DB_PASSWORD' 
              value: "SENTRY_DB_PASSWORD"
            - name: `SENTRY_REDIS_HOST' 
              value: "SENTRY_REDIS_HOST"
            - name: `SENTRY_REDIS_PORT' 
              value: "SENTRY_REDIS_PORT"
            - name: `SENTRY_MEMCACHED_HOST' 
              value: "SENTRY_MEMCACHED_HOST"
            - name: `SENTRY_MEMCACHED_PORT' 
              value: "SENTRY_MEMCACHED_PORT"
            - name: `SENTRY_SERVER_EMAIL' 
              value: "SENTRY_SERVER_EMAIL"
            - name: `SENTRY_EMAIL_HOST' 
              value: "SENTRY_EMAIL_HOST"
            - name: `SENTRY_EMAIL_PORT' 
              value: "SENTRY_EMAIL_PORT"
            - name: `SENTRY_EMAIL_USER' 
              value: "SENTRY_EMAIL_USER"
            - name: `SENTRY_EMAIL_PASSWORD' 
              value: "SENTRY_EMAIL_PASSWORD"
            - name: `SENTRY_EMAIL_USE_TLS' 
              value: "SENTRY_EMAIL_USE_TLS"
            - name: `SENTRY_SINGLE_ORGANIZATION' 
              value: "SENTRY_SINGLE_ORGANIZATION"

      volumes:
        - name: files
          hostPath:
            path: HOST_VOLUME_PATH/files
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
