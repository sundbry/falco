define(NAME, SERVICE-CONTROLLER_TAG)
# Requires privileged execution
kind: ReplicationController
apiVersion: v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: REPLICAS
  selector:
    name: NAME
    role: SERVICE
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
      annotations:
        pod.beta.kubernetes.io/subdomain: SERVICE
    spec:
      containers:
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 1194
              hostPort: 1194
          securityContext:
            privileged: true
            #capabilities:
            #  add:
            #    - NET_ADMIN
          env:
            - name: `VPN_VIRTUAL_NAT'
              value: "VPN_VIRTUAL_NAT"
            - name: `OPENVPN_CONF_PATH'
              value: /etc/openvpn/openvpn.conf
          volumeMounts:
            - name: SERVICE-secret
              mountPath: /etc/service/openvpn/secret
              readOnly: true
      volumes:
        - name: SERVICE-secret
          secret:
            secretName: SERVICE
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
