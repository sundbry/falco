define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))dnl
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
      annotations:
        pod.beta.kubernetes.io/subdomain: "SERVICE"
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 5556
          livenessProbe:
            httpGet:
              path: /
              port: 5556
            initialDelaySeconds: 15
            timeoutSeconds: 5
          readinessProbe:
            httpGet:
              path: /
              port: 5556
