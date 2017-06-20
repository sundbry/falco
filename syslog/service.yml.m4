kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - port: 514
      protocol: UDP
  selector:
    role: SERVICE
  type: ClusterIP
