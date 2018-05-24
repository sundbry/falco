define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    profile: PROFILE
spec:
  ports:
    - port: 3000
      protocol: TCP
  selector:
    role: SERVICE
    profile: PROFILE
  type: ClusterIP
