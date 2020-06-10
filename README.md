# Docker machine based on ubuntu 18.04 LTS

## Info

- unminimized
- locale (ita)
- lang (ita)
- nano, sudo, htop, bash-completion, cron, ssh, webssh
- ssh (port 22): `root:root` - `ubuntu:ubuntu`
- webssh: `container-ip:8888`
- docker daemon port: 2376
- python runlike

## Run

1. create folder in host directory `docker-data` and `ubuntu-home`
2. create and mount `daemon.json` for custom docker config (optional)
3. run `docker-compose up -d` 

### Compose

```
version: '2.4'

services:

  docker-machine-ubuntu18:
    container_name: docker-machine-ubuntu18
    hostname: docker
    image: adiprint/docker-machine-ubuntu18:latest
    network_mode: bridge
    privileged: true
    stdin_open: false
    tty: false
    volumes:
      - docker-data:/var/lib/docker:rw
      - ubuntu-home:/home/ubuntu:rw
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
      - ./daemon.json:/etc/docker/daemon.json:rw
    restart: "no"

volumes:

  docker-data:
    name: docker-data
    driver: local
    driver_opts:
      type: none
      device: $PWD/docker-data
      o: bind

  ubuntu-home:
    name: ubuntu-home
    driver: local
    driver_opts:
      type: none
      device: $PWD/ubuntu-home
      o: bind
```