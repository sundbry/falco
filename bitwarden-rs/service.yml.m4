define(NAME, SERVICE)
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  ports:
    - port: 80
      protocol: TCP
      name: http
    - port: 3012
      protocol: TCP
      name: ws
  selector:
    role: SERVICE
  type: ClusterIP
