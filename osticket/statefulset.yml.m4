define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: REPLICAS
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
          env:
            - name: `NGINX_CONF'
              value: "/etc/www/nginx.conf"
          volumeMounts:
            - name: www
              mountPath: /var/www
            - name: config
              mountPath: /etc/www
      volumes:
        - name: config
          hostPath:
            path: HOST_VOLUME_PATH/config
        - name: www
          hostPath:
            path: HOST_VOLUME_PATH/www
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
