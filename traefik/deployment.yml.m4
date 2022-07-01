kind: Deployment
apiVersion: apps/v1
metadata:
  name: traefik
  labels:
    k8s-app: traefik-ingress-lb
spec:
  replicas: 1
  selector:
    matchLabels:
      k8s-app: traefik-ingress-lb
  template:
    metadata:
      labels:
        k8s-app: traefik-ingress-lb
        name: traefik-ingress-lb
    spec:
      serviceAccountName: traefik-ingress-controller
      terminationGracePeriodSeconds: 60
      containers:
      - image: IMAGE
        name: traefik-ingress-lb
        ports:
        - name: http
          containerPort: 80
          hostPort: 80
        - name: https
          containerPort: 443
          hostPort: 443
        - name: admin
          containerPort: 8081
        args:
        - --providers.kubernetesingress
        - --entryPoints.web.address=:80
        - --entryPoints.websecure.address=:443
        - --entrypoints.websecure.http.tls.certResolver=leresolver
        - --entryPoints.traefik.address=:8081
        - --certificatesresolvers.leresolver.acme.email=ACME_EMAIL
        - --certificatesresolvers.leresolver.acme.storage=/data/acme.json
        - --certificatesresolvers.leresolver.acme.httpchallenge=true
        - --certificatesresolvers.leresolver.acme.httpchallenge.entrypoint=web
        - --api.dashboard=true
        - --api.insecure=true
        #- --api
        #- --kubernetes
        #- --logLevel=INFO
        #- --defaultentrypoints=http,https
        #- --entrypoints=Name:http Address::80
        #- --entrypoints=Name:https Address::443 TLS
        volumeMounts:
          - name: data
            mountPath: /data
      hostNetwork: true
      volumes:
        - name: data
          hostPath:
            path: HOST_VOLUME_PATH
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
