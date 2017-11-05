FROM janzell/proxygen-composer-npm:20171105

# Install Node
RUN curl -sSL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs

# Install Yarn for package installation and update NPM version
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn \
    && yarn global add npm && npm -v

# Clean and remove unnecessary packages to reduce image size.
RUN apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/*

# Start services
COPY .docker/entrypoint.sh /usr/local/bin/entrypoint.sh
