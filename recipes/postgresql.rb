monit "postgresql" do
  pidfile "/var/run/postgresql/9.1-main.pid"
  start "/etc/init.d/postgresql start"
  stop "/etc/init.d/postgresql stop"
end