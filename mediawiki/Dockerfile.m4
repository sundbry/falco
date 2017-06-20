FROM REPOSITORY/php-fpm

RUN apt-get -y -q update && apt-get -y -q install imagemagick

RUN mkdir /var/www/mediawiki \
  && curl -fL https://releases.wikimedia.org/mediawiki/1.28/mediawiki-1.28.1.tar.gz | tar -xz --strip-components=1 -C /var/www/mediawiki \
  && chown -R www-data:www-data /var/www/mediawiki \
	&& ln -s /var/www/mediawiki /var/www/mediawiki/wiki

# Extensions
RUN setuser www-data curl -fL https://extdist.wmflabs.org/dist/extensions/Lockdown-REL1_28-d281c27.tar.gz | setuser www-data tar -xz -C /var/www/mediawiki/extensions
RUN cd /var/www/mediawiki/extensions \
  && setuser www-data mkdir PrivatePageProtection \
	&& cd PrivatePageProtection \
  && setuser www-data wget -q https://phabricator.wikimedia.org/diffusion/SVN/browse/trunk/extensions/PrivatePageProtection/PrivatePageProtection.php?view=raw -O PrivatePageProtection.php \
  && setuser www-data wget -q https://phabricator.wikimedia.org/diffusion/SVN/browse/trunk/extensions/PrivatePageProtection/PrivatePageProtection.i18n.php?view=raw -O PrivatePageProtection.i18n.php \
  && setuser www-data wget -q https://phabricator.wikimedia.org/diffusion/SVN/browse/trunk/extensions/PrivatePageProtection/PrivatePageProtection.i18n.magic.php?view=raw -O PrivatePageProtection.i18n.magic.php
RUN setuser www-data git clone https://github.com/antonydandrea/LocalS3Repo2.git /var/www/mediawiki/extensions/LocalS3Repo

ADD nginx-default.conf /etc/service/nginx/nginx.conf

ENV LOCALSETTINGS_PHP /etc/service/mediawiki/localsettings.php
ADD run /etc/service/mediawiki/run
RUN chmod 0755 /etc/service/mediawiki/run
