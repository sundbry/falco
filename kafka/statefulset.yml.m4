define(NAME, SERVICE)dnl
define(INITIAL_LIVE_DELAY_SECONDS, ifelse(INITIAL_LIVE_DELAY_SECONDS, `', `15', INITIAL_LIVE_DELAY_SECONDS))dnl
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
spec:
  replicas: REPLICAS
  serviceName: "SERVICE"
  selector:
    matchLabels:
      role: "SERVICE"
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
            - containerPort: 9092
          env:
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
            - name: data
              mountPath: /var/local/kafka
            - name: secret
              mountPath: /etc/service/kafka/secret
              readOnly: true
            - name: logs
              mountPath: /usr/local/kafka/logs
          livenessProbe:
            exec:
              command: ["nc", "-z", "localhost", "9092"]
            initialDelaySeconds: 15
            periodSeconds: 15
            timeoutSeconds: 5
          readinessProbe:
            exec:
              command: ["nc", "-z", "localhost", "9092"]
      imagePullSecrets:
        - name: docker
      volumes:
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH
        - name: secret
          secret:
            secretName: SERVICE
        - name: logs
          emptyDir:
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
