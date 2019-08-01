define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: 1 # Do NOT replicate this controller -RS
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
            - containerPort: 9090
            - containerPort: 3000
          env: 
            - name: PROMETHEUS_CONFIG
              value: /var/lib/prometheus/prometheus.yml
            - name: `PROMETHEUS_URL'
              value: "PROMETHEUS_URL"
            - name: PROMETHEUS_STORAGE_TSDB_PATH
              value: "/var/lib/prometheus"
            - name: PROMETHEUS_STORAGE_TSDB_RETENTION_TIME
              value: "PROMETHEUS_RETENTION"
          volumeMounts:
            - name: data
              mountPath: /var/lib/prometheus
            - name: grafana-data
              mountPath: /var/lib/grafana
          livenessProbe:
            httpGet:
              path: /metrics
              port: 9090
          readinessProbe:
            httpGet:
              path: /metrics
              port: 9090
      volumes:
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH
        - name: grafana-data
          hostPath:
            path: GRAFANA_HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
