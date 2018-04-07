kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - port: 80
      protocol: TCP
      name: http
  selector:
    role: SERVICE
  type: ClusterIP
