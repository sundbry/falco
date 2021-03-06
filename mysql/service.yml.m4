kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - port: 3306
      protocol: TCP
  selector:
    role: SERVICE
  type: ClusterIP
  clusterIP: None
