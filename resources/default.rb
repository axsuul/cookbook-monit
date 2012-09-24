#
# Author:: James Hu (<axsuul@gmail.com>)
# Cookbook Name:: monit
# Resource:: monit
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

require 'chef/resource'

actions :enable, :disable
default_action :enable

attribute :process, :kind_of => String, :name_attribute => :true
attribute :pidfile, :kind_of => String
attribute :matching, :kind_of => String
attribute :start, :kind_of => String, :required => true
attribute :stop, :kind_of => String
attribute :uid, :kind_of => [Integer, String], :default => "root"
attribute :gid, :kind_of => [Integer, String]
attribute :conditions, :kind_of => Array, :default => []