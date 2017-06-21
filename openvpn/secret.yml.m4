apiVersion: v1
kind: Secret
metadata:
  name: SECRET
type: Opaque
data:
  openvpn.conf: OPENVPN_CONF_BASE64
