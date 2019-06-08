define(NAME, SERVICE)dnl
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
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
    spec:
      terminationGracePeriodSeconds: 60
      containers:
        - name: SERVICE
          image: IMAGE
          resources:
            limits:
              cpu: "2"
            requests:
              cpu: "0.5"
          ports:
            - containerPort: 9092
          env:
            - name: `SECOR_PROPERTIES'
              value: /etc/service/secor/secret/secor.properties
          volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: logs
              mountPath: /var/log
            - name: secret
              mountPath: /etc/service/secor/secret
              readOnly: true
      imagePullSecrets:
        - name: docker
      volumes:
        - name: tmp
          emptyDir:
        - name: logs
          emptyDir:
        - name: secret
          secret:
            secretName: SERVICE
