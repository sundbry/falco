define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))dnl
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    ifelse(PROFILE, `', `', profile: "PROFILE")
spec:
  ports:
    - port: 28015
      protocol: TCP
      name: rethinkdb-client
    - port: 8080
      protocol: TCP
      name: rethinkdb-admin
  selector:
    role: SERVICE
  type: ClusterIP
