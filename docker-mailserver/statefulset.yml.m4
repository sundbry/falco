define(`NAME', ifelse(PROFILE, `', SERVICE, SERVICE-PROFILE))
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: NAME
  labels:
    name: NAME
    role: SERVICE
  annotations:
    reloader.stakater.com/auto: "true"
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
        - name: SERVICE
          image: IMAGE
          ports:
            - containerPort: 25
              hostPort: 25
            - containerPort: 143
              hostPort: 143
            - containerPort: 587
              hostPort: 587
            - containerPort: 993
              hostPort: 993
            - containerPort: 995
              hostPort: 995
          securityContext:
            capabilities:
              add: ["NET_ADMIN"] # fail2ban support
          env:
            - name: `ENABLE_SPAMASSASSIN'
              value: "1"
            - name: `ENABLE_CLAMAV'
              value: "1"
            - name: `ENABLE_FAIL2BAN'
              value: "ENABLE_FAIL2BAN"
            - name: `ENABLE_POSTGREY'
              value: "ENABLE_POSTGREY"
            - name: `POSTGREY_DELAY'
              value: "300"
            - name: `ENABLE_POP3'
              value: "ENABLE_POP3"
            - name: `ONE_DIR'
              value: "1"
            - name: `SSL_TYPE'
              value: "SSL_TYPE"
            - name: `SSL_CERT_PATH'
              value: "/etc/ssl/private/tls.crt"
            - name: `SSL_KEY_PATH'
              value: "/etc/ssl/private/tls.key"
            - name: `SPOOF_PROTECTION'
              value: "1"
            - name: `ENABLE_SRS'
              value: "0"
            - name: `OVERRIDE_HOSTNAME'
              value: "OVERRIDE_HOSTNAME"
            - name: `POSTMASTER_ADDRESS'
              value: "POSTMASTER_ADDRESS"
            - name: `RELAY_HOST'
              value: "RELAY_HOST"
            - name: `RELAY_PORT'
              value: "RELAY_PORT"
            - name: `RELAY_USER'
              value: "RELAY_USER"
            - name: `RELAY_PASSWORD'
              value: "RELAY_PASSWORD"
            # https://github.com/tomav/docker-mailserver/issues/1227
            - name: `PERMIT_DOCKER'
              value: "network"
            - name: `POSTFIX_MESSAGE_SIZE_LIMIT'
              value: "ifdef(`POSTFIX_MESSAGE_SIZE_LIMIT', POSTFIX_MESSAGE_SIZE_LIMIT, `10240000')"
          volumeMounts:
            - name: mail
              mountPath: /var/mail
            - name: state
              mountPath: /var/mail-state
            - name: config
              mountPath: /tmp/docker-mailserver
            - name: ssl
              mountPath: /etc/ssl/private
              readOnly: true
      volumes:
        - name: mail
          hostPath:
            path: HOST_VOLUME_PATH/mail
        - name: state
          hostPath:
            path: HOST_VOLUME_PATH/state
        - name: config
          hostPath:
            path: HOST_VOLUME_PATH/config
        - name: ssl
          secret:
            secretName: CERT_SECRET
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
      hostNetwork: true
