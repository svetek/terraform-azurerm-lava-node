variable "hcloud_token" {
  sensitive = true
  default   = ""
}

module "lava-node" {
  source         = "../../"
#  source         = "Svetek/lava-node/hcloud"
#  version        = "0.0.1" # Set last module version

  hcloud_token   = var.hcloud_token
  service_name   = "lava-node"
  server_type    = "cpx11"
  os_base_image  = "debian-12"
  volume_size    = 30

  # VALIDATOR SETTINGS
  docker_image_version = "v0.27.1"
  moniker              = "SUPERNAME VALIDATOR"
  keyring_backend      = "test"
  keyring_name         = "keyring_name_default"

  # LAVA SETTINGS
  lava_network         = "testnet-2"
  lava_chain_id        = "lava-testnet-2"
  lava_rpc             = "https://public-rpc-testnet2.lavanet.xyz:443/rpc/"
  lava_peers           = "d5519e378247dfb61dfe90652d1fe3e2b3005a5b@lava-testnet.rpc.kjnodes.com:14456"
  lava_seeds           = "3a445bfdbe2d0c8ee82461633aa3af31bc2b4dc0@testnet2-seed-node.lavanet.xyz:26656,e593c7a9ca61f5616119d6beb5bd8ef5dd28d62d@testnet2-seed-node2.lavanet.xyz:26656"
}

output "node_host_ip" {
  value = module.lava-node.node_host_ip
}