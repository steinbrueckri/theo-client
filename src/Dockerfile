FROM debian:unstable-20220328
ARG THEO_AGENT_VERSION="v0.14.0"
LABEL maintainer="richard.steinbrueck@googlemail.com"

## Configuration ##############################################################
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN ln -snf /usr/share/zoneinfo/UTC /etc/localtime && echo UTC > /etc/timezone

## Init #######################################################################
COPY src/supervisord/supervisord-sshd.conf /etc/supervisor/conf.d/sshd.conf
COPY src/supervisord/supervisord.conf /etc/

# Runtime config ##############################################################
COPY src/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

# Packages ####################################################################
COPY src/packages.txt /tmp/packages.txt
# I use cat because i like cat!
# hadolint ignore=DL3008,DL3009,DL3015,SC2002,SC2046
RUN apt-get update && apt-get -q -y -o DPkg::Use-Pty=0 install $(cat /tmp/packages.txt) && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Node and Theo CLI #######################################################
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
# hadolint ignore=DL3008,DL3015
RUN apt-get install -y nodejs
RUN npm i -g theoapp-cli
RUN useradd -ms /bin/bash theo
COPY src/motd /etc/motd
RUN theo --help >> /etc/motd

# Install Theo agent
RUN curl -L -o /usr/sbin/theo-agent https://github.com/theoapp/theo-agent/releases/download/${THEO_AGENT_VERSION}/theo-agent-Linux-x86_64
RUN chmod +x /usr/sbin/theo-agent

# setup ssh ###################################################################
RUN mkdir /var/run/sshd /root/.ssh

# trust additional CAs ########################################################
RUN mkdir /tmp/certs
ADD http://aia.media-saturn.com/Media-Saturn-RootCA.crt /tmp/certs
ADD http://aia.media-saturn.com/Media-Saturn-SubCA-01.crt /tmp/certs
ADD http://aia.media-saturn.com/Media-Saturn-SubCA-02.crt /tmp/certs

# convert the certified from DER to PEM
# hadolint ignore=SC2045
RUN for c in $(ls /tmp/certs); \
      do openssl x509 -inform DER -in "/tmp/certs/$c" -out "/usr/share/ca-certificates/$c"; \
    done

RUN find /usr/share/ca-certificates/ | sed 's/\/usr\/share\/ca-certificates\///' > /etc/ca-certificates.conf
RUN /usr/sbin/update-ca-certificates

# Final #######################################################################
EXPOSE 22
WORKDIR /
CMD ["/entrypoint.sh"]
