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
          image: chorss/docker-pgadmin4:CONTAINER_TAG
          ports:
            - containerPort: 5050
          env:
            - name: `SERVER_MODE'
              value: "true"
            - name: `PGADMIN_PORT'
              value: "5050"
            - name: `PGADMIN_SETUP_EMAIL'
              value: "PGADMIN_SETUP_EMAIL"
            - name: `PGADMIN_SETUP_PASSWORD'
              value: "PGADMIN_SETUP_PASSWORD"
            - name: `MAIL_SERVER'
              value: "MAIL_SERVER"
            - name: `MAIL_USE_TLS'
              value: "MAIL_USE_TLS"
            - name: `MAIL_USERNAME'
              value: "MAIL_USERNAME"
            - name: `MAIL_PASSWORD'
              value: "MAIL_PASSWORD"
          volumeMounts:
            - name: data
              mountPath: /data
            - name: logs
              mountPath: /var/log
          livenessProbe:
            exec:
              command: ["curl", "localhost:5050"]
            initialDelaySeconds: 10
            periodSeconds: 15
            timeoutSeconds: 5
          readinessProbe:
            exec:
              command: ["curl", "localhost:5050"]
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
