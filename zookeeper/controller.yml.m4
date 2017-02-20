define(NAME, SERVICE-PROFILE-CONTROLLER_TAG)
define(`ZOOKEEPER_CLUSTER_SUBDOMAIN', SERVICE)
define(`ZOOKEEPER_NODE_HOSTNAME', SERVICE-PROFILE)
kind: ReplicationController
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
    profile: "PROFILE"
    zk-id: "ZK_ID"
spec:
  replicas: 1 # Do NOT replicate this controller -RS
  selector:
    name: NAME
    role: SERVICE
    profile: "PROFILE"
    zk-id: "ZK_ID"
  template:
    metadata:
      annotations:
        pod.beta.kubernetes.io/subdomain: ZOOKEEPER_CLUSTER_SUBDOMAIN
        pod.beta.kubernetes.io/hostname: ZOOKEEPER_NODE_HOSTNAME
      labels:
        name: NAME
        role: SERVICE
        profile: "PROFILE"
        zk-id: "ZK_ID"
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 2181
            - containerPort: 2888
            - containerPort: 3888
          env:
            - name: MYID
              value: "ZK_ID"
            - name: SERVERS
              value: ZK_NODES
            - name: LOG4J_PROPERTIES_PATH
              value: /etc/service/zookeeper/secret/log4j.properties
            - name: ZOODATA
              value: /var/local/zookeeper
          volumeMounts:
            - name: SERVICE-volume-ZK_ID
              mountPath: /var/local
            - name: SERVICE-secret
              mountPath: /etc/service/zookeeper/secret
              readOnly: true
          # Zookeepers respawning is dangerous - it can rapidly snowball into a wholecluster failure scenario when the dns keeps changing and nothing can stabilize
          #livenessProbe:
          #  exec:
          #    command: ["sh", "-c", "echo ruok | nc $(hostname -i) 2181 | grep imok"]
          #  initialDelaySeconds: 15
          #  periodSeconds: 15
          #  timeoutSeconds: 5
      volumes:
        - name: SERVICE-volume-ZK_ID
          hostPath:
            path: HOST_VOLUME_PATH
        - name: SERVICE-secret
          secret:
            secretName: SERVICE
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
