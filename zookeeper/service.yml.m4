define(NAME, SERVICE)dnl
kind: Service
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
spec:
  ports:
    - port: 2181
      protocol: TCP
      name: zk-client
    - port: 2888 
      protocol: TCP
      name: zk-peer
    - port: 3888 
      protocol: TCP
      name: zk-elect
  selector:
    role: SERVICE
  type: ClusterIP
  clusterIP: None
