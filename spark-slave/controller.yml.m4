define(NAME, SERVICE-CONTROLLER_TAG)
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
        - name: NAME
          image: REPOSITORY/SERVICE:CONTAINER_TAG
          ports:
            - containerPort: 8081
          env:
            - name: `SPARK_WORKER_CORES'
              value: "SPARK_WORKER_CORES"
            - name: `SPARK_WORKER_MEMORY'
              value: "SPARK_WORKER_MEMORY"
          livenessProbe:
                httpGet:
                  path: /
                  port: 8081
                initialDelaySeconds: 60 
                timeoutSeconds: 10
          readinessProbe:
                httpGet:
                  path: /
                  port: 8081
      imagePullSecrets:
        - name: docker
