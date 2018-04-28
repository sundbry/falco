kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - port: 8153
      protocol: TCP
      name: http
    - port: 8154
      nodePort: 30154
      protocol: TCP
      name: https
  selector:
    role: SERVICE
  type: NodePort
