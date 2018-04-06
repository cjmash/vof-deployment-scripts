#!/bin/bash

set -e
set -o pipefail

sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock

create_vof_user() {
echo "creating users"
  if ! id -u vof; then
    sudo useradd -m -s /bin/bash vof
  fi
}

setup_vof_code() {
echo " setting up code"
  sudo chown -R vof:vof /home/vof 
  cd /home/vof/app && bundle install && sudo apt-get install nginx -y
}

start_supervisor_service() {
  sudo service supervisor start
}

main() {
  create_vof_user
  setup_vof_code
  start_supervisor_service
}

main "$@"
