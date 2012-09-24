default['monit']['poll_period']         = 30
default['monit']['poll_start_delay']    = 0
default['monit']['logfile']             = "/var/log/monit.log"
default['monit']['notify_email']        = "notify@example.com"

default['monit']['httpd_enabled']       = true
default['monit']['httpd_port']          = 3737
default['monit']['httpd_password']      = "password"

default['monit']['mail_server']         = nil
default['monit']['mail_format_subject'] = "$SERVICE $EVENT"
default['monit']['mail_format_from']    = "monit@example.com"
default['monit']['mail_format_message'] = <<-EOS
Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.
Yours sincerely,
monit
EOS