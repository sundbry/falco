apiVersion: v1
kind: ServiceAccount
metadata:
  name: caddy-ingress-serviceaccount
  namespace: ENVIRONMENT

---

apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: caddy-ingress-clusterrole
rules:
  - apiGroups:
      - ""
    resources:
      - configmaps
      - nodes
      - pods
      - secrets
    verbs:
      - list
      - watch
  - apiGroups:
      - ""
    resources:
      - nodes
    verbs:
      - get
  - apiGroups:
      - ""
    resources:
      - services
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - "extensions"
    resources:
      - ingresses
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - ""
    resources:
        - events
    verbs:
        - create
        - patch
  - apiGroups:
      - "extensions"
    resources:
      - ingresses/status
    verbs:
      - update
  - apiGroups:
      - ""
    resources:
      - endpoints
    verbs:
      - get
      - list
      - watch
      - create

---

apiVersion: rbac.authorization.k8s.io/v1beta1
kind: Role
metadata:
  name: caddy-ingress-role
  namespace: ENVIRONMENT
rules:
  - apiGroups:
      - ""
    resources:
      - configmaps
      - pods
      - secrets
      - namespaces
    verbs:
      - get
  - apiGroups:
      - ""
    resources:
      - configmaps
    resourceNames:
      # Defaults to "<election-id>-<ingress-class>"
      # Here: "<ingress-controller-leader>-<caddy>"
      # This has to be adapted if you change either parameter
      # when launching the caddy-ingress-controller.
      - "ingress-controller-leader-caddy"
    verbs:
      - get
      - update
  - apiGroups:
      - ""
    resources:
      - configmaps
    verbs:
      - create
  - apiGroups:
      - ""
    resources:
      - endpoints
    verbs:
      - get

---

apiVersion: rbac.authorization.k8s.io/v1beta1
kind: RoleBinding
metadata:
  name: caddy-ingress-role-sa-binding
  namespace: ENVIRONMENT
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: caddy-ingress-role
subjects:
  - kind: ServiceAccount
    name: caddy-ingress-serviceaccount
    namespace: ENVIRONMENT

---

apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: caddy-ingress-clusterrole-sa-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: caddy-ingress-clusterrole
subjects:
  - kind: ServiceAccount
    name: caddy-ingress-serviceaccount
    namespace: ENVIRONMENT
