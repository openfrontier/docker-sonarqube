FROM sonarqube:5.6.7

MAINTAINER "xing.jiudong@trans-cosmos.com.cn"

# update openjdk
RUN set -ex; \
        \
        apt-get --purge remove -y \
                openjdk-8-jdk="$JAVA_DEBIAN_VERSION" \
                ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION"

ENV JAVA_VERSION 8u181
ENV JAVA_DEBIAN_VERSION 8u181-b13-2~deb9u1

RUN set -ex; \
        \
        if [ ! -d /usr/share/man/man1 ]; then \
                mkdir -p /usr/share/man/man1; \
        fi; \
        \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                openjdk-8-jdk="$JAVA_DEBIAN_VERSION" \
                ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
        ; \
        rm -rf /var/lib/apt/lists/*;

