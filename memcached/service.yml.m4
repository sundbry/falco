define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  ports:
    - port: 11211
      protocol: TCP
      name: redis-tcp
    - port: 11211
      protocol: UDP
      name: redis-udp
  selector:
    role: SERVICE
  type: ClusterIP
