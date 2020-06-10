#!/bin/bash

set -xev

sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.26.0/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

mkdir -p /home/$USER_NAME/tmp
chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/tmp
echo "export TMPDIR=/home/$USER_NAME/tmp" >> /home/$USER_NAME/.bashrc	
