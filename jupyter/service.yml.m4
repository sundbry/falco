kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - port: 8888
      protocol: TCP
      name: jupyter
  selector:
    role: SERVICE
  type: ClusterIP
