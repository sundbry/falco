define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  ports:
    - port: 9092
      protocol: TCP
      name: kafka-broker
  selector:
    role: SERVICE
  type: ClusterIP
