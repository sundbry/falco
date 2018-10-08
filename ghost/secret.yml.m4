apiVersion: v1
kind: Secret
metadata:
  name: SECRET
type: Opaque
data:
  config.production.json: CONFIG_PRODUCTION_JSON_BASE64
