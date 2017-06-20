apiVersion: v1
kind: Secret
metadata:
  name: SECRET
type: Opaque
data:
  log.conf: LOG_CONF_BASE64
