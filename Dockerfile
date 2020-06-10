FROM adiprint/ubuntu18-systemd-full:latest

# install docker from official repo

COPY ./install-docker.sh /install-docker.sh
RUN /install-docker.sh

# install docker compose

COPY ./install-docker-compose.sh /install-docker-compose.sh
RUN /install-docker-compose.sh

# enable docker daemon listening

COPY ./startup_options.conf /etc/systemd/system/docker.service.d/startup_options.conf

# install runlike

COPY ./install-python-runlike.sh /install-python-runlike.sh
RUN /install-python-runlike.sh

# fix python locale issues in container (resetting it utf8)

RUN set -xev; echo "export LC_ALL=it_IT.UTF-8" >> /home/$USER_NAME/.bashrc
RUN set -xev; echo "export LANG=it_IT.UTF-8" >> /home/$USER_NAME/.bashrc

# enable docker service

RUN systemctl enable docker.service

# define volume for docker and ubuntu home

VOLUME [ "/var/lib/docker" ]
VOLUME [ "/home/ubuntu" ]

# restore ownership for home

RUN chown -R $USER_NAME:$USER_NAME /home/$USER_NAME

# expose docker daemon port

EXPOSE 2376
