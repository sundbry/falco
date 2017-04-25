define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  ports:
    - port: 4511
      protocol: TCP
      name: mediawii
  selector:
    role: SERVICE
  type: ClusterIP
  clusterIP: None
