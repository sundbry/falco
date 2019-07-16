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
            - name: NGINX_CONF
              value: /home/app/secret/nginx.conf
          volumeMounts:
            - name: secret
              mountPath: /home/app/secret
              readOnly: true
            - name: logs
              mountPath: /var/log/nginx
            - name: html 
              mountPath: /var/www/html
              readOnly: true
          livenessProbe:
            httpGet:
              path: /nginx/status
              port: 81
            initialDelaySeconds: 5
            periodSeconds: 30
            timeoutSeconds: 10
          readinessProbe:
            httpGet:
              path: /nginx/status
              port: 81
      volumes:
        - name: secret
          secret:
            secretName: SERVICE
        - name: logs
          emptyDir:
        - name: tmp
          emptyDir:
        - name: html
          hostPath:
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      terminationGracePeriodSeconds: 60
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
