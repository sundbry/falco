0 2 * * * /bin/sh -c '/usr/bin/s3cmd --access_key "S3_ACCESS_KEY" --secret_key "S3_SECRET_KEY" sync /var/log/caddy/*.gz "S3_TARGET" && rm -f /var/log/caddy/*.gz'
