define(NAME, ifelse(PROFILE, `', SERVICE-CONTROLLER_TAG, SERVICE-PROFILE-CONTROLLER_TAG))
kind: ReplicationController
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
    profile: "PROFILE"
spec:
  replicas: 1
  selector:
    name: "NAME"
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
          image: gitlab/gitlab-ce:CONTAINER_TAG
          ports:
            - containerPort: 80
            - containerPort: 22
          volumeMounts:
            - name: etc
              mountPath: /etc/gitlab
            - name: data
              mountPath: /var/opt/gitlab
            - name: logs
              mountPath: /var/log/gitlab 
          #livenessProbe:
          #  exec:
          #    command: ["curl", "localhost:80"]
          #  initialDelaySeconds: 120
          #  periodSeconds: 15
          #  timeoutSeconds: 5
          #readinessProbe:
          #  exec:
          #    command: ["curl", "localhost:80"]
      imagePullSecrets:
        - name: docker
      volumes:
        - name: etc
          hostPath:
            path: HOST_ETC_PATH
        - name: data
          hostPath:
            path: HOST_DATA_PATH
        - name: logs
          emptyDir:
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
