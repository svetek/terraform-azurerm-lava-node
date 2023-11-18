resource "hcloud_server" "lava" {
  name          = "lava-${var.service_name}"
  image         = var.os_base_image
  server_type   = var.server_type
  datacenter    = var.hetzner_datacenter
  ssh_keys      = [ data.hcloud_ssh_key.admin_ssh_key.id ]
  firewall_ids  = [ hcloud_firewall.lava.id ]
  user_data     = templatefile("${path.module}/cloud_init.yml.tftpl", {
    opt                 = hcloud_volume.lava.linux_device
    version             = var.docker_image_version
    lava_network         = var.lava_network
    lava_chain_id        = var.lava_chain_id
    moniker              = var.moniker
    keyring_backend      = var.keyring_backend
    keyring_name         = var.keyring_name
    lava_rpc             = var.lava_rpc
    lava_peers           = var.lava_peers
    lava_seeds           = var.lava_seeds
  })

  public_net {
    ipv4_enabled = false
    ipv4 = hcloud_primary_ip.lava_primary_ip.id
    ipv6_enabled = false
  }

}

resource "hcloud_volume_attachment" "opt" {
  volume_id = hcloud_volume.lava.id

  server_id = hcloud_server.lava.id
  automount = false
}
