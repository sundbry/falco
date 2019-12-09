# OroCommerce 

### Installation Procedure
1. Create a new MySQL database for orocommerce
2. Create orocommerce service
3. Create orocommerce deployment
4. Shell into the pod
5. Add the following config to /var/www/orocommerce/config/config_${ORO_ENV}.yml

    doctrine:
      dbal:
        server_version: "5.7.0"

6. Edit parameters.yml:
  A) Setwith database connection info
  B) set `locale` to `en_US` (not `en`)
  C) change `secret` to a random secret
7. Run installation script

    cd /var/www/orocommerce
    setuser www-data ./bin/console oro:install --env=${ORO_ENV} --timeout=900 --skip-translations

If the script fails and you need to run again,
  1) `rm -rf /var/www/orocommerce/var/cache`
  2) set `installed` to `false` in config/parameters.yml
  3) run the above oro:install with the --drop-database option

8. Build assets

    setuser www-data /usr/bin/php  ./bin/console oro:assets:install --env=$ORO_ENV

