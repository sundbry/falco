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
  serviceName: "SERVICE"
  selector:
    matchLabels:
      role: SERVICE
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
    spec:
      terminationGracePeriodSeconds: 60
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 6379
          env: 
            - name: REDIS_DATA
              value: /var/redis
          volumeMounts:
            - name: data
              mountPath: /var/redis
          livenessProbe:
            exec:
              command: ["redis-cli", "ping"]
            initialDelaySeconds: 5
            periodSeconds: 15
            timeoutSeconds: 5
          readinessProbe:
            exec:
              command: ["redis-cli", "ping"]
      volumes:
        - name: data
          emptyDir: {}
      imagePullSecrets:
        - name: docker
