kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - port: 9000
      protocol: TCP
  selector:
    role: SERVICE
  type: ClusterIP
