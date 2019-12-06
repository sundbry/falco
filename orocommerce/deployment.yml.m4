define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: Deployment
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
ifelse(PROFILE, `', `',    profile: PROFILE)
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
ifelse(PROFILE, `', `',      profile: PROFILE)
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
ifelse(PROFILE, `', `',        profile: PROFILE)
      annotations:
        pod.beta.kubernetes.io/subdomain: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 80
          env: 
            - name: `ORO_ENV'
              value: "ifdef(ORO_ENV, `', ORO_ENV)"
          volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: nginx-logs
              mountPath: /var/log/nginx
            - name: oro
              mountPath: /var/www/orocommerce
          livenessProbe:
            httpGet:
              path: /nginx/status
              port: 81
            initialDelaySeconds: 30 
            timeoutSeconds: 5
          readinessProbe:
            httpGet:
              path: /nginx/status
              port: 81
      volumes:
        - name: tmp
          emptyDir:
        - name: nginx-logs
          emptyDir:
        - name: oro
          hostPath:
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
