define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
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
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 80
          volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: nginx-logs
              mountPath: /var/log/nginx
            - name: matomo-tmp
              mountPath: /var/www/matomo/tmp
            - name: config
              mountPath: /var/www/matomo/config
            - name: user
              mountPath: /var/www/matomo/misc/user
          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 30 
            timeoutSeconds: 5
          readinessProbe:
            httpGet:
              path: /
              port: 80
      volumes:
        - name: tmp
          emptyDir:
        - name: matomo-tmp
          emptyDir:
        - name: nginx-logs
          emptyDir:
        - name: config
          hostPath:
            path: HOST_VOLUME_PATH/config
        - name: user
          hostPath:
            path: HOST_VOLUME_PATH/user
      imagePullSecrets:
        - name: docker
