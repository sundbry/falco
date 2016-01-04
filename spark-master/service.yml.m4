kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - name: web
      port: 8080
      targetPort: 8080
      protocol: TCP
    - name: spark
      port: 7077
      targetPort: 7077
      protocol: TCP
  selector:
    role: SERVICE
  type: ClusterIP
