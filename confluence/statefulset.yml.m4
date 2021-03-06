define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
spec:
  replicas: 1
  serviceName: NAME
  selector:
    matchLabels:
      role: "SERVICE"
      profile: "PROFILE"
  template:
    metadata:
      labels:
        name: "NAME"
        role: "SERVICE"
        profile: "PROFILE"
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 8090
          env:
            - name: `CATALINA_OPTS'
              value: "CATALINA_OPTS"
            - name: `X_PROXY_NAME'
              value: "X_PROXY_NAME"
            - name: `X_PROXY_PORT'
              value: "X_PROXY_PORT"
            - name: `X_PROXY_SCHEME'
              value: "X_PROXY_SCHEME"
            - name: `X_SMTP_HOST'
              value: "X_SMTP_HOST"
            - name: `X_SMTP_PORT'
              value: "X_SMTP_PORT"
            - name: `X_SMTP_USER'
              value: "X_SMTP_USER"
            - name: `X_SMTP_PASSWORD'
              value: "X_SMTP_PASSWORD"
          volumeMounts:
            - name: data
              mountPath: /var/atlassian/confluence
            - name: logs
              mountPath: /opt/atlassian/confluence/logs
          livenessProbe:
            exec:
              command: ["/bin/true"]
          #  httpGet:
          #    path: /
          #    port: 8090
          #  initialDelaySeconds: 10
          #  periodSeconds: 15
          #  timeoutSeconds: 5
          readinessProbe:
            exec:
              command: ["/bin/true"]
            #httpGet:
            #  path: /
            #  port: 8090
      imagePullSecrets:
        - name: docker
      volumes:
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH
        #- name: secret
        #  secret:
        #    secretName: SERVICE
        - name: logs
          emptyDir:
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
