# Add your configuration below
variable "fastly_api_token" {
  type = "string"
}

provider "fastly" {
  api_key = "${var.fastly_api_token}"
}

resource "fastly_service_v1" "abcd-cbuckley-demo" {
  name = "abcd cbuckley demo"

  force_destroy = true

  domain {
    name    = "cbuckley.fastly-altitude-2017.com"
    comment = "Cbuckley domain"
  }

  backend {
    address               = "storage.googleapis.com"
    ssl_hostname          = "altitude-nyc-abcd-2017-stage.storage.googleapis.com"
    name                  = "altitude-nyc-abcd-2017-stage"
    port                  = 443
    first_byte_timeout    = 3000
    max_conn              = 200
    between_bytes_timeout = 1000
  }

  header {
    name        = "backend-host-override"
    action      = "set"
    type        = "request"
    destination = "http.Host"
    source      = "\"altitude-nyc-abcd-2017-stage.storage.googleapis.com\""
  }
}
