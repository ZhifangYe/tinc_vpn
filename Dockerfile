FROM ubuntu:xenial

# Prepare environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -yq build-essential libncurses5-dev libreadline6-dev libzlcore-dev zlib1g-dev liblzo2-dev libssl-dev curl wget

# Install tinc
RUN mkdir -p tinc && \
    curl -sSL https://www.tinc-vpn.org/packages/tinc-1.1pre16.tar.gz | tar -xzC tinc --strip-components=1 && \
    cd tinc && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -r tinc

EXPOSE 655/tcp 655/udp
VOLUME /usr/local/etc/tinc

ENTRYPOINT [ "/usr/local/sbin/tinc" ]
CMD [ "start", "-D" ]