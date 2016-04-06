kind: ReplicationController
apiVersion: v1
metadata:
  name: SERVICE-CONTROLLER_TAG
  labels:
    name: SERVICE-CONTROLLER_TAG
    role: SERVICE
spec:
  replicas: 1
  selector:
    name: SERVICE-CONTROLLER_TAG
    role: SERVICE
  template:
    metadata:
      labels:
        name: SERVICE-CONTROLLER_TAG
        role: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: sheepkiller/kafka-manager:CONTAINER_TAG
          ports:
            - containerPort: 9000
          env: 
            - name: `ZK_HOSTS'
              value: ZOOKEEPER_CONNECT
            - name: `APPLICATION_SECRET'
              value: APPLICATION_SECRET
