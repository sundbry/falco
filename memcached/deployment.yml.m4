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
            - containerPort: 11211
          env:
            - name: `MEMCACHED_SIZE_MB'
              value: "MEMCACHED_SIZE_MB"
          volumeMounts:
            - name: logs
              mountPath: /var/log
            - name: tmp
              mountPath: /tmp
      volumes:
        - name: logs
          emptyDir:
        - name: tmp
          emptyDir:
      imagePullSecrets:
        - name: docker
      terminationGracePeriodSeconds: 60
