kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - port: 8090
      protocol: TCP
  selector:
    role: SERVICE
  type: ClusterIP
