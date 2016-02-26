define(`NAME', ifelse(PROFILE, `',
                 SERVICE-CONTROLLER_TAG,
                 SERVICE-PROFILE-CONTROLLER_TAG))
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
            - name: `RIAK_NODE_NAME'
              value: "SERVICE-PROFILE"
          volumeMounts:
            - name: NAME-data
              mountPath: /var/lib/riak
      volumes:
        - name: NAME-data
          hostPath:
            path: HOST_VOLUME_PATH
      imagePullSecrets:
        - name: docker
