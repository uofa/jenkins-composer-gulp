FROM jenkins
MAINTAINER Zeno Zaplaic "zeno.zaplaic@abdn.ac.uk"
ENV REFRESHED_AT 2017-06-20

# Switch to root
USER root

# Git & Curl
RUN apt-get update && apt-get install -y git curl

# Install PHP and Composer
RUN apt-get install php5 libapache2-mod-php5 php5-mcrypt php5-ldap -y
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