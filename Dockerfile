FROM ubuntu:18.04

# install packages
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        gcc \
        git \
        gnupg-agent \
        make \
        ruby \
        ruby-dev\
        software-properties-common \
        ssh

# install Puppet PDK and Bolt
RUN curl -fsSL https://apt.puppet.com/puppet-tools-release-bionic.deb -o /tmp/puppet-tools-release-bionic.deb && \
    dpkg -i /tmp/puppet-tools-release-bionic.deb && \
    apt-get update && \
    apt-get install pdk && \
    apt-get -y install puppet-bolt

# install Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get -y install docker-ce-cli

 # Clean up after installations
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/puppet-tools-release-bionic.deb

# install ruby gems for testing modules
RUN gem install bundler

# Persist bash history
ARG USERNAME=root

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && echo $SNIPPET >> "/root/.bashrc"
