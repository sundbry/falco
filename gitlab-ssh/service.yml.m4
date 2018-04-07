kind: Service
apiVersion: v1
metadata:
  name: SERVICE
  labels:
    name: SERVICE
spec:
  ports:
    - port: 22
      nodePort: 30022
      protocol: TCP
      name: ssh
  selector:
    role: gitlab
  type: NodePort
