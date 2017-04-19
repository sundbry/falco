define(NAME, SERVICE-PROFILE-CONTROLLER_TAG)
define(KAFKA_HOSTNAME, SERVICE-PROFILE)
define(INITIAL_LIVE_DELAY_SECONDS, ifelse(INITIAL_LIVE_DELAY_SECONDS, `', `15', INITIAL_LIVE_DELAY_SECONDS))
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
      annotations:
        pod.beta.kubernetes.io/subdomain: SERVICE
        pod.beta.kubernetes.io/hostname: KAFKA_HOSTNAME
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
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
            - name: KAFKA_HEAP_OPTS 
              value: "-Xmx1G -Xms1G"
          volumeMounts:
            - name: SERVICE-volume-BROKER_ID
              mountPath: /var/local
            - name: SERVICE-secret
              mountPath: /etc/service/kafka/secret
              readOnly: true
            - name: logs
              mountPath: /usr/local/kafka/logs
          livenessProbe:
            exec:
              command: ["nc", "-z", "localhost", "9092"]
            initialDelaySeconds: INITIAL_LIVE_DELAY_SECONDS
            periodSeconds: 15
            timeoutSeconds: 5
          readinessProbe:
            exec:
              command: ["nc", "-z", "localhost", "9092"]
      imagePullSecrets:
        - name: docker
      volumes:
        - name: SERVICE-volume-BROKER_ID
          hostPath:
            path: HOST_VOLUME_PATH
        - name: SERVICE-secret
          secret:
            secretName: SERVICE
        - name: logs
          emptyDir:
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
