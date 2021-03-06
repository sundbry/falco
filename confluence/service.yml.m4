define(NAME, ifdef(`PROFILE', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE), SERVICE))dnl
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  ports:
    - port: 8090
      protocol: TCP
  selector:
    role: SERVICE
ifelse(`PROFILE', `',    profile: PROFILE)
  type: ClusterIP
