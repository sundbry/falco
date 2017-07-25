define(NAME, SERVICE-PROFILE-CONTROLLER_TAG)
kind: ReplicationController
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: 1
  selector:
    name: NAME
    role: SERVICE
  template:
    metadata:
      annotations:
        pod.beta.kubernetes.io/subdomain: "SERVICE"
        pod.beta.kubernetes.io/hostname: "SERVICE-PROFILE"
      labels:
        name: NAME
        role: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 80
              hostPort: 80
            - containerPort: 81
            - containerPort: 443
              hostPort: 443
          env:
            - name: CADDYFILE
              value: /etc/service/caddy/secret/Caddyfile
            - name: CADDYPATH
              value: /etc/service/caddy/data
          volumeMounts:
            - name: SERVICE-secret
              mountPath: /etc/service/caddy/secret
              readOnly: true
            - name: logs
              mountPath: /var/log
            - name: data
              mountPath: /etc/service/caddy/data
          livenessProbe:
                httpGet:
                  path: /health
                  port: 81
                initialDelaySeconds: 30
                timeoutSeconds: 1
          readinessProbe:
                httpGet:
                  path: /health
                  port: 81
      volumes:
        - name: SERVICE-secret
          secret:
            secretName: SERVICE
        - name: logs
          emptyDir:
        - name: data
          hostPath: 
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
