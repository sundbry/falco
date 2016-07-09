FROM REPOSITORY/php5-fpm

RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-4.5.3.tar.gz \
  && echo "835b68748dae5a9d31c059313cd0150f03a49269 *wordpress.tar.gz" | sha1sum -c - \
  && tar -xzf wordpress.tar.gz -C /usr/src/ \
  && rm wordpress.tar.gz \
  && chown -R www-data:www-data /usr/src/wordpress
