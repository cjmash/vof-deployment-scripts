#!/bin/bash

set -e
set -o pipefail

create_vof_user() {
  if ! id -u vof; then
    sudo useradd -m -s /bin/bash vof
  fi
}
install_nginx() {
sudo apt-get install nginx

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
