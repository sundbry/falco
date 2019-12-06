define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
spec:
  replicas: 1 
  serviceName: SERVICE
  selector:
    matchLabels:
      role: SERVICE
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
    spec:
      containers:
        - name: avahi
          image: solidnerd/avahi:AVAHI_CONTAINER_TAG
          volumeMounts:
            - name: avahi-config
              mountPath: /etc/avahi
        - name: samba
          image: dperson/samba:CONTAINER_TAG
          env:
            - name: TZ
              value: "UTC"
          volumeMounts:
            - name: samba-tmp
              mountPath: /tmp
            - name: samba-data
              mountPath: /var/local/samba
          args:
            - "-s"
            - "SAMBA_NAME;/var/local/samba;yes;no"
            - "-u"
            - "SAMBA_USER1;SAMBA_PASSWORD1"
      volumes:
        - name: avahi-config
          hostPath:
            path: HOST_VOLUME_PATH/avahi
        - name: samba-data
          hostPath:
            path: HOST_VOLUME_PATH/data
        - name: samba-tmp
          emptyDir:
      hostNetwork: true
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
