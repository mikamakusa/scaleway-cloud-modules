output "hubs" {
  value = {
    for hub in scaleway_iot_hub.this : hub => {
      id                     = hub.id
      created_at             = hub.created_at
      updated_at             = hub.updated_at
      status                 = hub.status
      endpoint               = hub.endpoint
      device_count           = hub.device_count
      connected_device_count = hub.connected_device_count
      mqtt_ca_url            = hub.mqtt_ca_url
      mqtt_ca                = hub.mqtt_ca
    }
  }
}

output "devices" {
  value = {
    for device in scaleway_iot_device.this : device => {
      id               = device.id
      created_at       = device.created_at
      updated_at       = device.updated_at
      certificate_key  = device.certificate[0].key
      status           = device.status
      last_activity_at = device.last_activity_at
      is_connected     = device.is_connected
    }
  }
}

output "networks" {
  value = {
    for network in scaleway_iot_network.this : network => {
      id         = network.id
      region     = network.region
      created_at = network.created_at
      endpoint   = network.endpoint
      secret     = network.secret
    }
  }
}

output "routes" {
  value = {
    for route in scaleway_iot_route.this : route => {
      id         = route.id
      region     = route.region
      created_at = route.created_at
    }
  }
}
