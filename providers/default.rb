#
# Author:: James Hu (<axsuul@gmail.com>)
# Cookbook Name:: monit
# Provider:: monit
#
# Copyright:: 2012, James Hu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

config_path = lambda { |new_resource| "/etc/monit/conf.d/#{new_resource.process}.conf" }
build_template_variables = lambda do |new_resource|
  variables = {}
  variables[:process] = new_resource.process
  variables[:start] = new_resource.start
  variables[:conditions] = new_resource.conditions

  if new_resource.pidfile
    variables[:check_with] = "with pidfile #{new_resource.pidfile}"
  else
    # Match the process name if pidfile isn't provided, unless matching
    # has been explicity specified
    matching = resource.process unless resource.matching
    variables[:check_with] = "matching #{matching}"
  end

  # If no stop command is given but a pidfile has been provided, 
  # we will use a SIGTERM by default
  if !new_resource.stop and new_resource.pidfile
    variables[:stop] = "kill -s SIGTERM `cat #{new_resource.pidfile}`"
  else
    variables[:stop] = new_resource.stop
  end

  if new_resource.uid
    variables[:run_as] = "as uid #{new_resource.uid}"
    variables[:run_as] += " and gid #{new_resource.gid}" if new_resource.gid
  end

  variables
end

action :enable do
  log @new_resource.inspect

  template config_path.call(new_resource) do
    source "monit.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables build_template_variables.call(new_resource)
    notifies :restart, resources(:service => "monit"), :delayed
    action :create
  end
end

action :disable do
  template config_path.call(new_resource) do
    notifies :restart, resources(:service => "monit"), :delayed
    action :delete
  end
end