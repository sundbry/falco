define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))dnl
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    ifelse(PROFILE, `', `', profile: PROFILE)
spec:
  ports:
    - port: 3000
      protocol: TCP
  selector:
    role: SERVICE
    ifelse(PROFILE, `', `', profile: PROFILE)
  type: ClusterIP
