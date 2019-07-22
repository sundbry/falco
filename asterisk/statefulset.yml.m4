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
            - containerPort: 5060
              hostPort: 5060
            - containerPort: 8088
              hostPort: 8088
            - containerPort: 8089
              hostPort: 8089
            # Port range
            # Host networking should not require us to specify all ports
            # "10000-10099:10000-10099/udp"
          volumeMounts:
            - name: config
              mountPath: /etc/asterisk
            - name: data
              mountPath: /var/lib/asterisk
            - name: spool
              mountPath: /var/spool/asterisk
            - name: log
              mountPath: /var/log
      volumes:
        - name: config
          hostPath:
            path: HOST_VOLUME_PATH/config
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH/data
        - name: spool
          hostPath:
            path: HOST_VOLUME_PATH/spool
        - name: log
          emptyDir:
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
      hostNetwork: true
