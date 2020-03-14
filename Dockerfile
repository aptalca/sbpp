FROM lsiobase/nginx:3.11

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SBPP_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="driz"

ENV REMOVE_SETUP_DIRS=false

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
        curl \
        php7-bcmath \
        php7-ctype \
        php7-curl \
        php7-gd \
	php7-gmp \
        php7-iconv \
        php7-ldap \
        php7-mbstring \
        php7-mcrypt \
        php7-phar \
	php7-pdo \
        php7-pdo_mysql \
	php7-mysqli \
	php7-mysqlnd \
        php7-tokenizer \
        php7-xml \
        php7-xmlreader \
        php7-zip \
        tar && \
 echo "**** configure php-fpm to pass env vars ****" && \
 sed -i \
        's/;clear_env = no/clear_env = no/g' \
 /etc/php7/php-fpm.d/www.conf && \
 echo "env[PATH] = /usr/local/bin:/usr/bin:/bin" >> /etc/php7/php-fpm.conf && \
 echo "**** install sbpp ****" && \
 SBPP_RELEASE=$(curl -sX GET "https://api.github.com/repos/sbpp/sourcebans-pp/releases/latest" \
      | awk '/tag_name/{print $4;exit}' FS='[""]') && \
 mkdir -p \
      /var/www/html/ && \
 curl -o \
      /tmp/sbpp.tar.gz -L \
      "https://github.com/sbpp/sourcebans-pp/releases/download/${SBPP_RELEASE}/sourcebans-pp-${SBPP_RELEASE}.webpanel-only.tar.gz" && \
 tar xf \
      /tmp/sbpp.tar.gz -C \
      /var/www/html/ && \
 echo "**** cleanup ****" && \
 rm -rf \
        /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME ["/config"]
