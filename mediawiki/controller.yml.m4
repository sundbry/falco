define(`NAME', ifelse(PROFILE, `',
                 SERVICE-CONTROLLER_TAG,
                 SERVICE-PROFILE-CONTROLLER_TAG))
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
        pod.beta.kubernetes.io/subdomain: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 4511
          env: 
            - name: LOCALSETTINGS_PHP
              value: /etc/service/mediawiki/secret/localsettings.php
          volumeMounts:
            - name: SERVICE-secret
              mountPath: /etc/service/mediawiki/secret
              readOnly: true
            - name: tmp
              mountPath: /tmp
            - name: nginx-logs
              mountPath: /var/log/nginx
          livenessProbe:
            httpGet:
              path: /nginx/status
              port: 81
            initialDelaySeconds: 30 
            timeoutSeconds: 5
          readinessProbe:
            httpGet:
              path: /nginx/status
              port: 81
      volumes:
        - name: tmp
          emptyDir:
        - name: nginx-logs
          emptyDir:
        - name: SERVICE-secret
          secret:
            secretName: SERVICE
      imagePullSecrets:
        - name: docker
