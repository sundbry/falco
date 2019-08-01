kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - port: 9090
      protocol: TCP
      name: prometheus
    - port: 3000
      protocol: TCP
      name: grafana
  selector:
    role: SERVICE
  type: ClusterIP
