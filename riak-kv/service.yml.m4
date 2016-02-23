define(NAME, ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    ifelse(PROFILE, `', `', profile: "PROFILE")
spec:
  ports:
    - port: 8087
      targetPort: 8087
      protocol: TCP
      name: protobuf-api
    - port: 8098
      targetPort: 8098
      protocol: TCP
      name: http-api
    - port: 8093
      targetPort: 8093
      protocol: TCP
      name: solr-api
  selector:
    role: SERVICE
    ifelse(PROFILE, `', `', profile: "PROFILE")
  type: ClusterIP
