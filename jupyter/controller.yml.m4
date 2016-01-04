kind: ReplicationController
apiVersion: v1
metadata:
  name: SERVICE.CONTROLLER_TAG
  labels:
    name: SERVICE.CONTROLLER_TAG
    role: SERVICE
spec:
  replicas: 1
  selector:
    name: SERVICE.CONTROLLER_TAG
    role: SERVICE
  template:
    metadata:
      labels:
        name: SERVICE.CONTROLLER_TAG
        role: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: REPOSITORY/SERVICE:CONTAINER_TAG
          ports:
            - containerPort: 8888
          livenessProbe:
                httpGet:
                  path: /
                  port: 8888
                initialDelaySeconds: 60 
                timeoutSeconds: 10
          readinessProbe:
                httpGet:
                  path: /
                  port: 8888
      imagePullSecrets:
        - name: docker
