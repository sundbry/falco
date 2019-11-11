apiVersion: v1
kind: Secret
metadata:
  name: SECRET
type: Opaque
data: 
  s3cfg: ifdef(S3CFG_BASE64, S3CFG_BASE64, `""')
