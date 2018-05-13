kind: Service
apiVersion: v1
metadata:
  name: SERVICE-PROFILE
  labels:
    name: SERVICE-PROFILE
spec:
  ports:
    - port: 80
      protocol: TCP
  selector:
    role: SERVICE
    profile: PROFILE
  type: ClusterIP
