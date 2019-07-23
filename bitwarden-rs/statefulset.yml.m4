define(`NAME', SERVICE)
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: 1 # Do NOT replicate this controller -RS
  serviceName: SERVICE
  selector:
    matchLabels:
      role: SERVICE
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 80
            - containerPort: 3012 # Websocket?
          env: 
            - name: WEBSOCKET_ENABLED
              value: "true"
            - name: SIGNUPS_ALLOWED
              value: "false"
            - name: LOG_FILE
              value: "/data/bitwarden.log"
          volumeMounts:
            - name: data
              mountPath: /data
      volumes:
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
