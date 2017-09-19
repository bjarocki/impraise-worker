job "impraise" {
  datacenters = ["dc1"]
  type = "service"
  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    auto_revert = false
    canary = 0
  }

  group "redis" {
    count = 1
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }
    ephemeral_disk {
      size = 300
    }

    task "redis" {
      driver = "docker"

      config {
        image = "redis"
        port_map {
          process = 6379
        }
      }
      resources {
        cpu    = 500
        memory = 256
        network {
          mbits = 10
          port "process" {}
        }
      }

      service {
        name = "redis"
        port = "process"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }

  group "disque" {
    count = 1
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }
    ephemeral_disk {
      size = 300
    }

    task "disque" {
      driver = "docker"
      config {
        image = "richnorth/disque"
        port_map {
          disque   = 7711
        }
      }
      resources {
        cpu    = 500
        memory = 256
        network {
          mbits = 10
          port "disque" {}
        }
      }
      service {
        name = "disque"
        port = "disque"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }

  group "impraise-worker" {
    count = 1
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }
    ephemeral_disk {
      size = 300
    }

    task "watch" {
      driver = "docker"
      config {
        image = "devopsdance/impraise-worker"
        args = ["watch", "close-write"]
        volumes = [
          "/srv/docker/storage/impraise:/home"
        ]
      }
      env {
        "WATCH_DIRECTORY" = "/home"
        "DISQUE_QUEUE"    = "894e6396-a38a-4c63-8eac-a453376bc26e"
      }
      resources {
        cpu    = 500
        memory = 256
        network {
          mbits = 10
        }
      }
    }

    task "consume" {
      driver = "docker"
      config {
        image = "devopsdance/impraise-worker"
        args = ["consume", "jobs"]
        volumes = [
          "/srv/docker/storage/impraise:/home"
        ]
      }
      env {
        "WATCH_DIRECTORY" = "/home"
        "DISQUE_QUEUE"    = "894e6396-a38a-4c63-8eac-a453376bc26e"
      }
      resources {
        cpu    = 500
        memory = 256
        network {
          mbits = 10
        }
      }
    }
  }
}
