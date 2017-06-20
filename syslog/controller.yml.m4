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
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 514
          volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: var-log
              mountPath: /var/log
            - name: syslog-conf-d
              mountPath: /etc/syslog-ng/conf.d
      volumes:
        - name: tmp
          emptyDir:
        - name: var-log
          emptyDir:
        - name: syslog-conf-d
          secret:
            secretName: SERVICE
      imagePullSecrets:
        - name: docker
