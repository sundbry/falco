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
            - containerPort: 80
          volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: nginx-logs
              mountPath: /var/log/nginx
            - name: cache
              mountPath: /var/www/vtiger/cache
            - name: storage
              mountPath: /var/www/vtiger/storage
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
        - name: cache
          emptyDir:
        - name: nginx-logs
          emptyDir:
        - name: config
          hostPath:
            path: HOST_VOLUME_PATH/config
        - name: storage
          hostPath:
            path: HOST_VOLUME_PATH/storage
      imagePullSecrets:
        - name: docker
