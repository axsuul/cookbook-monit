monit "redis" do
  pidfile "/var/run/redis_6379.pid"
  start "/etc/init.d/redis start"
  stop "/etc/init.d/redis stop"
end