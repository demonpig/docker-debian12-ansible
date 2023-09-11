FROM debian:12
LABEL maintainer="Max Mitschke"

ENV container=docker

# Install package dependencies for systemd
RUN apt update && apt upgrade -y \
  && apt install -y systemd initscripts sudo \
  && apt clean

# Install systemd -- See https://hub.docker.com/_/centos/
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install package dependencies for Ansible
# openjdk libs are for ansible-rulebook
RUN apt update \
  && apt install -y python3.11-minimal python3.11-venv openjdk-17-jdk-headless openjdk-17-jre-headless \
  && apt clean

# Setup virtual environment
ADD ./files/ /
RUN update-alternatives --install /usr/bin/python3 python /usr/bin/python3.11 1 \
  && sh /usr/local/sbin/setup-env.sh

ENV PATH="/opt/ansible/bin:$PATH"

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
