FROM lscr.io/linuxserver/code-server:latest
LABEL org.opencontainers.image.source=https://github.com/Volcar144/code-server

USER root

# Install apt packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl \
    wget \
    build-essential ca-certificates \
    texlive-latex-extra texlive-xetex \
    libreadline-dev libncursesw5-dev \
    libssl-dev libsqlite3-dev \
    tk-dev libgdbm-dev \
    libc6-dev libbz2-dev \
    libffi-dev zlib1g-dev \
    php php-symfony \
    php-json php-yaml php-xml \
    php-dev php-mbstring php-curl php-bz2 \
    mariadb-server \
    gfortran && \
    rm -rf /var/lib/apt/lists/*
    
# Install Node.js (latest LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

# Install OpenJDK, Maven, and SBT
# Install OpenJDK, Maven, and SBT
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl gnupg; \
    apt-get install -y --no-install-recommends openjdk-21-jdk maven; \
    mkdir -p /usr/share/keyrings; \
    curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" \
      | gpg --dearmor -o /usr/share/keyrings/sbt.gpg; \
    echo "deb [signed-by=/usr/share/keyrings/sbt.gpg] https://repo.scala-sbt.org/scalasbt/debian all main" \
      > /etc/apt/sources.list.d/sbt.list; \
    echo "deb [signed-by=/usr/share/keyrings/sbt.gpg] https://repo.scala-sbt.org/scalasbt/debian /" \
      > /etc/apt/sources.list.d/sbt_old.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends sbt; \
    rm -rf /var/lib/apt/lists/*


RUN chown -R 1000:1000 /opt
USER 1000

# Set up environment
ENV SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

WORKDIR /home/coder/project
