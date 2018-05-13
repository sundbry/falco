apiVersion: v1
kind: Secret
metadata:
  name: SECRET-PROFILE
type: Opaque
data:
  parameters.yml: PARAMETERS_YML_BASE64
