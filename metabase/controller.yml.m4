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
    profile: PROFILE
spec:
  replicas: 1
  selector:
    name: NAME
    role: SERVICE
    profile: PROFILE
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
        profile: PROFILE
      annotations:
        pod.beta.kubernetes.io/subdomain: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: metabase/metabase:CONTAINER_TAG
          ports:
            - containerPort: 3000
          env:
            - name: `MB_DB_TYPE'
              value: "MB_DB_TYPE"
            - name: `MB_DB_DBNAME'
              value: "MB_DB_DBNAME"
            - name: `MB_DB_PORT'
              value: "MB_DB_PORT"
            - name: `MB_DB_USER'
              value: "MB_DB_USER"
            - name: `MB_DB_PASS'
              value: "MB_DB_PASS"
            - name: `MB_DB_HOST'
              value: "MB_DB_HOST"
            - name: `MB_ENCRYPTION_SECRET_KEY'
              value: "MB_ENCRYPTION_SECRET_KEY"
            - name: `JAVA_TIMEZONE'
              value: "JAVA_TIMEZONE"
          volumeMounts:
            - name: tmp
              mountPath: /tmp
          livenessProbe:
            httpGet:
              path: /
              port: 3000
            initialDelaySeconds: 30 
            timeoutSeconds: 15
          readinessProbe:
            httpGet:
              path: /
              port: 3000
      volumes:
        - name: tmp
          emptyDir:
