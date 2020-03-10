FROM capnajax/lepp

LABEL maintainer="Cap'n Ajax <thomas@capnajax.com>"

ENV PHP_MEMORY_LIMIT="64M"

ADD http://download.phpmyfaq.de/files/phpmyfaq-3.0.0.tar.gz /usr/local/lepp/phpMyFAQ-3.0.0.tar.gz

RUN set -x \
	&& [ "$(md5sum /usr/local/lepp/phpMyFAQ-3.0.0.tar.gz | sed -e 's/ .*//')" == 80e9d51f2b34e15a42cbe2182cc789ee ] \
	&& cd /usr/local/lepp \
	&& tar xzf phpMyFAQ-3.0.0.tar.gz \
	&& rm /www/* \
	&& mv phpmyfaq/* phpmyfaq/.htaccess /www \
	&& rmdir phpmyfaq \
	&& chown -R www:www /www

# phpMyFaq settings

# COPY configs/database.php /www/config/database.php

RUN set -x \
	&& echo "safe_mode = off" >> /etc/php7/php.ini \
	&& echo "register_globals = off" >> /etc/php7/php.ini \
#	&& sed -i "s|;\s*extension=fileinfo|extension=fileinfo|i" /etc/php7/php.ini \
#	&& sed -i "s|;\s*extension=pdo_pgsql|extension=pdo_pgsql|i" /etc/php7/php.ini \
#	&& sed -i "s|;\s*extension=pgsql|extension=pgsql|i" /etc/php7/php.ini \
	&& sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini


CMD [ "bash" ]



# docker build -t capnajax/phpmyfaq-lepp .
# docker commit -m "phpMyFaw on a LEPP stack" -a "capnajax" <container id> capnajax/phpmyfaq-lepp

