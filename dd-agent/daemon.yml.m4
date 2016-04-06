define(NAME, SERVICE-CONTROLLER_TAG)
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: NAME
spec:
  template:
    metadata:
      labels:
        name: NAME
        role: SERVICE
      name: NAME
    spec:
      containers:
      - image: datadog/docker-dd-agent:kubernetes
        imagePullPolicy: Always
        name: dd-agent
        ports:
          - containerPort: 8125
            name: dogstatsdport
        env:
          - name: `API_KEY'
            value: DATADOG_API_KEY
        volumeMounts:
          - name: dockersocket
            mountPath: /var/run/docker.sock
          - name: procdir
            mountPath: /host/proc
            readOnly: true
          - name: cgroups
            mountPath: /host/sys/fs/cgroup
            readOnly: true
          - name: dd-agent-conf
            mountPath: /conf.d
            readOnly: true
      volumes:
        - hostPath:
            path: /var/run/docker.sock
          name: dockersocket
        - hostPath:
            path: /proc
          name: procdir
        - hostPath:
            path: /sys/fs/cgroup
          name: cgroups
        - hostPath:
            path: /var/local/dd-agent/conf.d
          name: dd-agent-conf
