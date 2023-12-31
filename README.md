# Debian 12 Ansible Test Image

This repo is based on my forked [AlmaLinux 9 image](https://github.com/demonpig/docker-almalinux9-ansible). It has been modified for Debian 12. This image is serving the same purpose: Ansible playbook and role testing.

### Build

- Clone this repository and change into the directory
- Build image with one of the following commands

  ```bash
  docker build -f ./Containerfile --no-cache -t localhost/docker-debian12-ansible:latest .
  ```

  ```bash
  podman build -f ./Containerfile --no-cache -t localhost/docker-debian12-ansible:latest .
  ```

### Usage

- Run the image with one of the following commands
  ```
  docker run -it --rm -d -v /sys/fs/cgroup:/sys/fs/cgroup:rw --privileged localhost/docker-debian12-ansible:latest
  ```
  ```
  podman run -it --rm -d -v /sys/fs/cgroup:/sys/fs/cgroup:rw --privileged localhost/docker-debian12-ansible:latest
  ```