#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

# Private subnet has no IPv6 NAT. Apt prefers AAAA and hangs.
echo 'Acquire::ForceIPv4 "true";' >/etc/apt/apt.conf.d/99force-ipv4
echo 'precedence ::ffff:0:0/96  100' >>/etc/gai.conf

# Route exists before NAT forwards. Wait for a real IPv4 fetch.
for i in $(seq 1 30); do
  if curl -4 -fsS --max-time 5 -o /dev/null http://ap-southeast-1.ec2.archive.ubuntu.com; then
    break
  fi
  sleep 10
done

for i in $(seq 1 8); do
  apt-get update && break
  sleep 15
done

apt-get install -y python3 python3-pip git software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible

rm -rf /home/ubuntu/devops-bootcamp-project
for i in $(seq 1 8); do
  git clone https://github.com/AfiqNasruddin/devops-bootcamp-project.git \
    /home/ubuntu/devops-bootcamp-project && break
  rm -rf /home/ubuntu/devops-bootcamp-project
  sleep 15
done

chown -R ubuntu:ubuntu /home/ubuntu/devops-bootcamp-project