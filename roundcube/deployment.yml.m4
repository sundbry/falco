define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))dnl
kind: Deployment
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: REPLICAS
  selector:
    matchLabels:
      name: NAME
      role: SERVICE
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 0
      maxSurge: 1
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
    spec:
      subdomain: SERVICE
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 80
          env:
            - name: `ROUNDCUBEMAIL_DEFAULT_HOST'
              value: "ROUNDCUBEMAIL_DEFAULT_HOST"
            - name: `ROUNDCUBEMAIL_SMTP_SERVER'
              value: "ROUNDCUBEMAIL_SMTP_SERVER"
            - name: `ROUNDCUBEMAIL_DB_TYPE'
              value: "ROUNDCUBEMAIL_DB_TYPE"
            - name: `ROUNDCUBEMAIL_DB_HOST'
              value: "ROUNDCUBEMAIL_DB_HOST"
            - name: `ROUNDCUBEMAIL_DB_USER'
              value: "ROUNDCUBEMAIL_DB_USER"
            - name: `ROUNDCUBEMAIL_DB_PASSWORD'
              value: "ROUNDCUBEMAIL_DB_PASSWORD"
            - name: `ROUNDCUBEMAIL_DB_NAME'
              value: "ROUNDCUBEMAIL_DB_NAME"
          volumeMounts:
            - name: tmp
              mountPath: /tmp
          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 10
            periodSeconds: 30
            timeoutSeconds: 10
          readinessProbe:
            httpGet:
              path: /
              port: 80
      volumes:
        - name: tmp
          emptyDir:
      terminationGracePeriodSeconds: 60
