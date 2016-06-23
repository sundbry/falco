FROM gentoo/stage3-amd64

RUN emerge-webrsync
ADD make.conf /etc/portage/make.conf
RUN emerge --sync --quiet && eselect news read --quiet && eselect profile set $(eselect profile list | grep default/linux/amd64/13.0/no-multilib | awk '{print $1}' | sed -e 's/[^0-9]//g')

RUN emerge --update --deep --newuse --quiet @world
ADD package.use /etc/portage/package.use
#RUN emerge runit syslog-ng vixie-cron ca-certificates
#ENTRYPOINT /sbin/runit-init
