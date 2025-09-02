## CSI Driver NFS
This module installs the [CSI Driver NFS Driver](https://github.com/kubernetes-csi/csi-driver-nfs) using the official chart. 

## Important Note
The chart defaults to kube-system for its namespace. The bundled RBAC (ClusterRoles, ClusterRoleBindings, etc.) is written to expect service accounts inside that namespace. If you install it into another namespace without modifying the RBAC manifests, it will fail because the ClusterRoleBindings point to service accounts in kube-system.
