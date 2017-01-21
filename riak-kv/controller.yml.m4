define(`NAME', ifelse(PROFILE, `',
                 SERVICE-CONTROLLER_TAG,
                 SERVICE-PROFILE-CONTROLLER_TAG))dnl
dnl Subdomain must match an existing Kubernetes service
define(`RIAK_CLUSTER_SUBDOMAIN', SERVICE)dnl
define(`RIAK_NODE_HOSTNAME', SERVICE-PROFILE)dnl
define(`RIAK_NODE_NAME', riak@RIAK_NODE_HOSTNAME.RIAK_CLUSTER_SUBDOMAIN.RIAK_CLUSTER_DOMAIN)dnl
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
          image: IMAGE
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
            - name: NAME-user-modules
              mountPath: /usr/local/lib/riak/user
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

        # Reference: https://github.com/kubernetes/kubernetes/blob/release-1.3/examples/javaweb-tomcat-sidecar/README.md
        - name: user-ebin
          image: USER_EBIN_IMAGE
          command: ["sh", "-c", "USER_EBIN_EXPORT && echo Modules ready && sleep infinity"]
          volumeMounts:
            - name: NAME-user-modules
              mountPath: /out

      volumes:
        - name: NAME-data
          hostPath:
            path: HOST_VOLUME_PATH
        - name: NAME-user-modules
          emptyDir: {}
      imagePullSecrets:
        - name: docker
      nodeSelector:
        ifelse(NODE_SELECT, `', `', `kubernetes.io/hostname: 'NODE_SELECT)
