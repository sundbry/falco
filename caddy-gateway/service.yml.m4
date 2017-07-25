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
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
    - name: https
      protocol: TCP
      port: 443
      targetPort: 443
  selector:
    role: SERVICE
  type: ClusterIP
  externalIPs:
    - EXTERNAL_IP
