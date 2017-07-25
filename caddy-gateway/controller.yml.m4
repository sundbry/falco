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
            - containerPort: 12015
            - containerPort: 443
              hostPort: 443
          env:
            - name: `ACME_EMAIL'
              value: "ACME_EMAIL"
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
          args:
            - /caddy-ingress-controller
            - --default-backend-service=DEFAULT_BACKEND_SERVICE
          volumeMounts:
            - name: logs
              mountPath: /var/log
            - name: data
              mountPath: /root/.caddy
          #livenessProbe:
          #      httpGet:
          #        path: /healthz
          #        port: 12015
          #      initialDelaySeconds: 30
          #      timeoutSeconds: 5
          #readinessProbe:
          #      httpGet:
          #        path: /healthz
          #        port: 12015
      volumes:
        - name: logs
          emptyDir:
        - name: data
          hostPath: 
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
