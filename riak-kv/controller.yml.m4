define(`NAME', ifelse(PROFILE, `',
                 SERVICE-CONTROLLER_TAG,
                 SERVICE-PROFILE-CONTROLLER_TAG))
dnl Subdomain must match an existing Kubernetes service
define(`RIAK_CLUSTER_SUBDOMAIN', SERVICE)
define(`RIAK_NODE_HOSTNAME', SERVICE-PROFILE)
define(`RIAK_NODE_NAME', riak@RIAK_NODE_HOSTNAME.RIAK_CLUSTER_SUBDOMAIN.RIAK_CLUSTER_DOMAIN)
kind: ReplicationController
apiVersion: v1
metadata:
  name: NAME
spec:
  replicas: 1 # Use profiles to replicate
  selector:
    name: NAME
    role: SERVICE
    profile: "PROFILE"
  template:
    metadata:
      annotations:
        pod.beta.kubernetes.io/subdomain: RIAK_CLUSTER_SUBDOMAIN
        pod.beta.kubernetes.io/hostname: RIAK_NODE_HOSTNAME
      labels:
        name: NAME
        role: SERVICE
        profile: "PROFILE"
    spec:
      containers:
        - name: SERVICE
          image: REPOSITORY/SERVICE:CONTAINER_TAG
          ports:
            - containerPort: 4369
            - containerPort: 8087
            - containerPort: 8093
            - containerPort: 8098
            - containerPort: 8099
            - containerPort: 8985
          env:
            - name: `KUBE_NAMESPACE'
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
            - name: `RIAK_CLUSTER_SIZE'
              value: "RIAK_CLUSTER_SIZE"
            - name: `RIAK_CLUSTER_JOIN'
              value: "RIAK_CLUSTER_JOIN"
            - name: `RIAK_NODE_NAME'
              value: "RIAK_NODE_NAME"
          volumeMounts:
            - name: NAME-data
              mountPath: /var/lib/riak
          livenessProbe:
            httpGet:
              path: /ping
              port: 8098
            initialDelaySeconds: 15
            periodSeconds: 10
            timeoutSeconds: 5
          readinessProbe:
            httpGet:
              path: /ping
              port: 8098

      volumes:
        - name: NAME-data
          hostPath:
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
