resource "helm_release" "csi_driver_nfs" {
  name       = "csi-driver-nfs"
  namespace  = var.kube_namespace
  repository = "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts"
  chart      = "csi-driver-nfs"
  version    = "4.11.0"

  values = [
    yamlencode({
      externalSnapshotter = {
        enabled = true
      }
      controller = {
        runOnControlPlane = true
        replicas          = 2
      }
    })
  ]
}
