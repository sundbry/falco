define(NAME, SERVICE-PROFILE-CONTROLLER_TAG)
kind: ReplicationController
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
    profile: "PROFILE"
spec:
  replicas: 1 # Use profiles to replicate this controller
  selector:
    name: NAME
    role: SERVICE
    profile: "PROFILE"
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
        profile: "PROFILE"
    spec:
      containers:
        - name: SERVICE
          image: REPOSITORY/SERVICE:CONTAINER_TAG 
          ports:
            - containerPort: 9092
          env:
            - name: `BROKER_ID'
              value: "BROKER_ID"
            - name: `ZOOKEEPER_CONNECT'
              value: ZOOKEEPER_CONNECT
            - name: KAFKA_LOG_DIRS
              value: /var/local/kafka
            - name: LOG4J_PROPERTIES_PATH
              value: /etc/service/kafka/secret/log4j.properties
            - name: SERVER_PROPERTIES_M4_PATH
              value: /etc/service/kafka/secret/server.properties.m4
          volumeMounts:
            - name: SERVICE-volume-BROKER_ID
              mountPath: /var/local
            - name: SERVICE-secret
              mountPath: /etc/service/kafka/secret
              readOnly: true
      imagePullSecrets:
        - name: docker
      volumes:
        - name: SERVICE-volume-BROKER_ID
          hostPath:
            path: HOST_VOLUME_PATH
        - name: SERVICE-secret
          secret:
            secretName: SERVICE
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
