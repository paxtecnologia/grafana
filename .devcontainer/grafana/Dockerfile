FROM grafana/grafana-oss:latest

# Argumentos configuráveis
ARG USERNAME=dev-user
ARG USER_UID=1000
ARG USER_GID=1000

USER root

RUN apk update && \
    apk add --no-cache \
      bash \
      sudo \
      git \
      curl \
      vim \
      less \
      shadow \
      openssh \
      jq \
      moreutils \
      python3 \
      py3-pip && \
    ln -sf python3 /usr/bin/python

# Cria grupo e usuário com shell bash
RUN addgroup -g ${USER_GID} ${USERNAME} && \
    adduser -u ${USER_UID} -G ${USERNAME} -s /bin/bash -D ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /workspace && \
    chown -R ${USERNAME}:${USERNAME} /workspace

# Define o shell bash como padrão no ambiente
ENV SHELL=/bin/bash

# Usa o usuário e define a pasta de trabalho como /workspace
USER ${USERNAME}
WORKDIR /workspace