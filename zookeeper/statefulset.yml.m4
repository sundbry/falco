define(NAME, SERVICE)
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
spec:
  replicas: REPLICAS
  serviceName: "SERVICE"
  selector:
    matchLabels:
      role: SERVICE
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
            - containerPort: 2181
            - containerPort: 2888
            - containerPort: 3888
          env:
            - name: SERVERS
              value: ZK_NODES
            - name: LOG4J_PROPERTIES_PATH
              value: /etc/service/zookeeper/secret/log4j.properties
            - name: ZOODATA
              value: /var/local/zookeeper
          volumeMounts:
            - name: data
              mountPath: /var/local/zookeeper
            - name: secret
              mountPath: /etc/service/zookeeper/secret
              readOnly: true
          livenessProbe:
            exec:
              command: ["/etc/service/zookeeper/health"]
      volumes:
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH
        - name: secret
          secret:
            secretName: SERVICE
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
