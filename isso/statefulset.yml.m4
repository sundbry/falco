define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))dnl
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
spec:
  replicas: REPLICAS
  serviceName: "SERVICE"
  selector:
    matchLabels:
      role: "SERVICE"
      ifelse(PROFILE, `', `', `profile: "'PROFILE`"')
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
        ifelse(PROFILE, `', `', `profile: "'PROFILE`"')
    spec:
      terminationGracePeriodSeconds: 60
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 1234
          env:
            - name: ISSO_CONFIG
              value: "/home/app/secret/isso.cfg"
          volumeMounts:
            - name: data
              mountPath: /var/lib/isso
            - name: secret
              mountPath: /home/app/secret
#          livenessProbe:
#            httpGet:
#              path: /
#              port: 2368
#            initialDelaySeconds: 15
#            periodSeconds: 15
#            timeoutSeconds: 5
#          readinessProbe:
#            httpGet:
#              path: /
#              port: 2368
      imagePullSecrets:
        - name: docker
      volumes:
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH
        - name: secret
          secret:
            secretName: SERVICE
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
