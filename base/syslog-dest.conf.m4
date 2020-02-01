template t_with_loghost {
  template("SYSLOG_DESTINATION_TEMPLATE");
};

destination d_central_syslog {
  network("SYSLOG_DESTINATION"
    port(514)
    transport("udp")
    throttle(10000)
    template(t_with_loghost)
  );
};

log { 
	source(s_src); 
	destination(d_central_syslog); 
};
