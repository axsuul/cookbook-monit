monit "elasticsearch" do
  pidfile "#{node.elasticsearch[:pid_path]}/#{node.elasticsearch[:node_name].to_s.gsub(/\W/, '_')}.pid"
  start "/etc/init.d/elasticsearch start"
  stop "/etc/init.d/elasticsearch stop"
end