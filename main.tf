#Create target group
#Link to terraform documentation - https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/lb_target_group
resource "yandex_lb_target_group" "nursultan-1994-tg" {
  name      = "my-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = "<your subnet-id>" //ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone
    address   = "<internal IP address of the target>" //internal IP address of the target 
  }

  target {
    subnet_id = "<your subnet-id>" //ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone
    address   = "<internal IP address of the target>" //internal IP address of the target  
  }
}

#Create network load balancer 
#Link to terraform documentation - https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer#external_address_spec
resource "yandex_lb_network_load_balancer" "nursultan-1994-nlb" {
  name = "nursultan-1994-nlb"

  listener {
    name = "nursultan-1994-nlb"
    port = 8080
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.nursultan-1994-tg.id}" //An AttachedTargetGroup resource

    healthcheck {
      name = "http"
      http_options {
        port = 8080
        path = "/ping"
      }
    }
  }
}