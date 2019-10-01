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
              value: "false"
            - name: SIGNUPS_ALLOWED
              value: "false"
            - name: LOG_FILE
              value: "/data/bitwarden.log"
            - name: `DATABASE_URL'
              value: "DATABASE_URL"
            - name: ENABLE_DB_WAL
              value: "false"
            - name: `ADMIN_TOKEN'
              value: "ADMIN_TOKEN"

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
