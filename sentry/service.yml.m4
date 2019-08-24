define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  ports:
    - port: 9000
      protocol: TCP
      name: http
  selector:
    role: SERVICE
  type: ClusterIP
