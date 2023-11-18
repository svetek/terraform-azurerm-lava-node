variable "hcloud_token" {
  sensitive = true
  description = "HETZNER API KEY"
}

# fsn1, hel1, ash or hil
# nbg1-dc3, fsn1-dc14, hel1-dc2, ash-dc1 or hil-dc1
variable "hetzner_location" {
  default = "fsn1"
  description = "HETZNER datacenter location"
}

variable "hetzner_datacenter" {
  default = "fsn1-dc14"
  description = "HETZNER datacenter"
}

variable "os_base_image" {
  default = "debian12"
  description = "Linux OS type"
}

variable "server_type" {
  default = "cpx11"
  description = "Hetzner VM type"
}

variable "service_name" {
  default = "lava-node"
  description = "Service name"
}

variable "lava_network" {
  default = "testnet"
  description = "LAVA network mainnet / testnet / devnet "
}

variable "volume_size" {
  default = 10
  description = "Additional volume attached to VM for persistent data (configs, genesis, chain data)"
}

variable "docker_image_version" {
  default = "v0.27.1-cache"
  description = "Docker image version tag"
}

variable "moniker" {
  default = "SUPERNAME VALIDATOR"
  description = "LAVA Moniker for Validator"
}

variable "keyring_backend" {
  default = "test"
  description = "set Keyring Backend type os / file / test"
}

variable "keyring_name" {
  default = "keyring_name_default"
  description = "Keyring name"
}

variable "lava_chain_id" {
  default = "lava-testnet-2"
}

variable "lava_rpc" {}

variable "lava_peers" {}

variable "lava_seeds" {}