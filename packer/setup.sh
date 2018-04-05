#!/bin/bash

set -e
set -o pipefail

#sudo rm /var/cache/apt/archives/lock
#sudo rm /var/lib/dpkg/lock

create_vof_user() {
echo "creating users"
  if ! id -u vof; then
    sudo useradd -m -s /bin/bash vof
  fi
}
install_nginx() {
echo "installing nginx"
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo apt-get update
sudo apt-get install nginx -y

}
setup_vof_code() {
  sudo chown -R vof:vof /home/vof 
  cd /home/vof/app && bundle install 
}

start_supervisor_service() {
  sudo service supervisor start
}

main() {
  create_vof_user
  install_nginx
  setup_vof_code
  start_supervisor_service
}

main "$@"
