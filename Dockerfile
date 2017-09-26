FROM jenkins/jenkins
MAINTAINER Zeno Zaplaic "zeno.zaplaic@abdn.ac.uk"
ENV REFRESHED_AT 2017-09-26

# Install Blue Ocean and a couple of useful plugins
RUN /usr/local/bin/install-plugins.sh blueocean workflow-job ssh-agent

# Switch to root
USER root

# Git & Curl
RUN apt-get update && apt-get install -y git curl git-ftp

# Required for `add-apt-repository`
RUN apt-get install software-properties-common -y
# Add 3rd party repository for php 5.6
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key 4F4EA0AAE5267A6C
RUN apt-get update
# Install PHP and Composer
RUN apt-get install php5.6 \
                    libapache2-mod-php5.6 \
                    php5.6-dom \
                    php5.6-ldap \
                    php5.6-mbstring \
                    php5.6-mcrypt -y
RUN wget https://getcomposer.org/installer && php installer && php composer.phar && mv composer.phar /usr/local/bin/composer

# Install Nodejs & npm
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get install -y nodejs

# Install Gulp
RUN npm install -g gulp-cli

# Cleanup
RUN rm -rf /var/lib/apt/lists/*

# Rollback to using the `jenkins` user
USER jenkins
