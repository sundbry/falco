define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
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
  selector:
    role: SERVICE
ifelse(PROFILE, `', `',    profile: PROFILE)
  type: ClusterIP
