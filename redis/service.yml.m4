define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  ports:
    - port: 6379
      protocol: TCP
      name: redis
  selector:
    role: SERVICE
  type: ClusterIP
