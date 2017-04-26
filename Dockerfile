FROM factual/docker-cdh5-devbox

MAINTAINER fanchen<fanchen1988@gmail.com>

# Common tool
RUN apt-get update
RUN apt-get install -y tmux silversearcher-ag vim-nox
RUN apt-get install -y curl wget mosh jq tig
RUN apt-get -y upgrade

# Vim plugin YouCompleteMe

RUN apt-get update
RUN apt-get install -y build-essential cmake
RUN apt-get -y upgrade
RUN apt-get install -y python-dev python3-dev
ARG VIM_PLUGIN_PATH=/opt/vim-plugin
ARG YCM_FILE_NAME=YouCompleteMe
RUN mkdir -p $VIM_PLUGIN_PATH
ADD $YCM_FILE_NAME $VIM_PLUGIN_PATH/$YCM_FILE_NAME
RUN ${VIM_PLUGIN_PATH}/${YCM_FILE_NAME}/install.py --clang-completer --tern-completer

# Mongo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update
RUN apt-get install -y mongodb-org

# PostgreSQL
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib

# Docker Engine & Compose
RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list
RUN apt-get update
RUN apt-get install -y docker-engine
RUN curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

#cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
