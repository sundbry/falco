define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
    profile: "PROFILE"
spec:
  replicas: 1
  serviceName: SERVICE
  selector:
    matchLabels:
      role: "SERVICE"
      profile: "PROFILE"
  template:
    metadata:
      labels:
        name: "NAME"
        role: "SERVICE"
        profile: "PROFILE"
    spec:
      containers:
        - name: SERVICE
          image: gocd/gocd-server:CONTAINER_TAG
          ports:
            - containerPort: 8153
          volumeMounts:
            - name: home
              mountPath: /home/go
            - name: data
              mountPath: /godata
            - name: logs
              mountPath: /godata/logs
          env:
            - name: GO_SERVER_PORT
              value: ""
          #livenessProbe:
          #  exec:
          #    command: ["curl", "localhost:8153"]
          #  initialDelaySeconds: 120
          #  periodSeconds: 15
          #  timeoutSeconds: 5
          #readinessProbe:
          #  exec:
          #    command: ["curl", "localhost:8153"]
      imagePullSecrets:
        - name: docker
      volumes:
        - name: home
          hostPath:
            path: HOST_HOME_PATH
        - name: data
          hostPath:
            path: HOST_DATA_PATH
        - name: logs
          emptyDir:
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
