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
      annotations:
        pod.beta.kubernetes.io/subdomain: "SERVICE"
    spec:
      containers:
        - name: NAME
          image: hjacobs/tiny-docker-http-test
          ports:
            - containerPort: 8080
