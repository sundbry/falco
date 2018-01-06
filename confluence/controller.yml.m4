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
          image: cptactionhank/atlassian-confluence:CONTAINER_TAG
          ports:
            - containerPort: 8090
          env:
            - name: `CATALINA_OPTS'
              value: "CATALINA_OPTS"
          volumeMounts:
            - name: data
              mountPath: /var/atlassian/confluence
            - name: logs
              mountPath: /opt/atlassian/confluence/logs
          livenessProbe:
            exec:
              command: ["curl", "localhost:8090"]
            initialDelaySeconds: 10
            periodSeconds: 15
            timeoutSeconds: 5
          readinessProbe:
            exec:
              command: ["curl", "localhost:8090"]
      imagePullSecrets:
        - name: docker
      volumes:
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH
        #- name: secret
        #  secret:
        #    secretName: SERVICE
        - name: logs
          emptyDir:
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
