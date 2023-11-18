
## Deploy LAVA-NODE

### Create project on hetzner
* Go to https://console.hetzner.cloud/
* Press + New project and enter name of project 
* Go to created project and Security 
* Press add SSH key and upload your admin ssh public key with name "admin ssh key"
* Go to API Tab and Create API Tokens

### Prepare terraform directory structure and deploy 

Example files you can take: 
```bash
git clone git@github.com:svetek/terraform-hcloud-lava-node.git
cd terraform-hcloud-lava-node/examples/lava-node
```

Example how to use module: 
```yaml
variable "hcloud_token" {
  sensitive = true
  default   = ""
}

  module "lava-node" {
  source         = "svetek/lava-node/hcloud"
  version        = "0.1.11" # Set last module version

  hcloud_token   = var.hcloud_token
  service_name   = "lava-node"
  server_type    = "cpx31"
  os_base_image  = "debian-12"
  volume_size    = 150

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
```

```bash
export TF_VAR_hcloud_token="PUT HEZTNER API TOKEN"

$ terraform init
$ terraform plan
$ terraform apply

# Print LAVA-NODE ip
$ terraform output 
```

Run `terraform destroy` when you don't need these resources.

### Login to LAVA-NODE inside VM

```bash
ssh root@<lava node ip>
```

### Configuration and Manage 

#### START / STOP / LOGS DOCKER STACK CONTAINERS
```bash
# Go to docker stack folder 
cd /opt/sercvice

# list running docker stack containers 
docker-compose ps 

# stop docker stack containers 
docker-compose stop 

# start docker stack containers 
docker-compose up -d 

# print realtime logs docker stack containers 
docker-compose logs -f --tail=500
```


#### Directory structure
```bash 
/opt/service/
|-- cache.env
|-- docker-compose.yml
|-- node.env
|-- provider.env
`-- volumes
    `-- lava_root
        |-- config
        |   |-- addrbook.json
        |   |-- app.toml
        |   |-- client.toml
        |   |-- config.toml
        |   |-- genesis.json
        |   |-- node_key.json
        |   |-- priv_validator_key.json
        |   `-- rpcprovider.yml
        `-- keyring-test
            |-- fee9c959b2527fd5798ee8a408e0cd0659dbc2c0.address
            `-- keyring_name_default.info
```

node.env - parameters for LAVA node container
provider.env - parameters for LAVA provider container
cache.env - parameters for LAVA cache container

On /opt/service/volumes/lava_root/config you can see all lava configuration for custom change 

#### How to update 

```bash
cd /opt/service
vim docker-compose.yml (Change version image tag)

docker-compose up -d 
```

