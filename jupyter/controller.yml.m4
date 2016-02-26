define(NAME, SERVICE-CONTROLLER_TAG)
kind: ReplicationController
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: 1
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
        - name: NAME
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
