resource "hcloud_volume" "lava" {
  name      = "lava-${var.service_name}-volumes"
  location = var.hetzner_location
  size      = var.volume_size
  automount = false
  format    = "xfs"
  #  mount_point = "/opt"
  labels = {
    VM = "${var.service_name}"
    Service = "LAVA-NODE"
  }

#  lifecycle {
#    prevent_destroy = true
#  }
}
