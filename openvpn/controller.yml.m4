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
            capabilities:
              add:
                - NET_ADMIN
          env:
            - name: `VPN_VIRTUAL_NAT'
              value: "VPN_VIRTUAL_NAT"
            - name: `OPENVPN_CONF_PATH'
              value: /etc/openvpn/openvpn.conf
          volumeMounts:
            - name: SERVICE-secret
              mountPath: /etc/openvpn
              readOnly: true
      volumes:
        - name: SERVICE-secret
          secret:
            secretName: SERVICE
      imagePullSecrets:
        - name: docker
