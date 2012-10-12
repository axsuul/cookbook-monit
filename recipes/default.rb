#
# Cookbook Name:: monit
# Recipe:: default
#
# Copyright 2012, James Hu
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

package "monit"

service "monit" do
  action [:enable, :start]
  enabled true
  supports [:start, :restart, :stop]
end

template "/etc/default/monit" do
  owner "root"
  group "root"
  mode 0700
  source 'default.erb'
  notifies :restart, resources(:service => "monit"), :delayed
end

template "/etc/monit/monitrc" do
  owner "root"
  group "root"
  mode 0700
  source 'monitrc.erb'
  notifies :restart, resources(:service => "monit"), :delayed
end

# Configs created by our monit resource go here
directory "/etc/monit/conf.d/" do
  owner  'root'
  group 'root'
  mode 0755
  action :create
  recursive true
end