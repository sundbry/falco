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
spec:
  replicas: REPLICAS
  selector:
    name: NAME
    role: SERVICE
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: onyx/onyx-dashboard:CONTAINER_TAG
          args:
            - "ZOOKEEPER_ADDRESS"
            - "true"
          ports:
            - containerPort: 3000
          readinessProbe:
            httpGet:
              path: /
              port: 3000
          livenessProbe:
            httpGet:
              path: /
              port: 3000
