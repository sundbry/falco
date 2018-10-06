define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  ports:
    - port: 2368
      protocol: TCP
      name: ghost-http
  selector:
    role: SERVICE
    ifelse(PROFILE, `', `', `profile: "'PROFILE`"')
  type: ClusterIP
