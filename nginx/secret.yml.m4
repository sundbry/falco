apiVersion: v1
kind: Secret
metadata:
  name: SECRET
type: Opaque
data:
  nginx.conf: NGINX_CONF_BASE64
