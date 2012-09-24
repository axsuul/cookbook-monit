Description
===========

Provides a set of primitives for managing monit and associated monit configurations.

PLEASE NOTE - The resource/providers in this cookbook are under heavy development.
An attempt is being made to keep the resource simple/stupid by starting with less
sophisticated firewall implementations first and refactor/vet the resource definition
with each successive provider.

Requirements
============

Chef
----
Tested on `0.10.10` but newer versions should work just fine.

Platform
--------

Tested on

* Ubuntu 11.04
* Ubuntu 12.04

but older and newer platforms should work just fine.

Recipes
=======

default
-------

Installs `monit` as a service using the package manager and drops off a `monitrc`. Make sure to check out the default attributes file!

Usage
=====

A `monit` resource is provided to easily manage monit configurations. Here's a simple example

```ruby
monit "postgresql" do
  pidfile "/var/run/postgresql/9.1-main.pid"
  start "/etc/init.d/postgresql start"
  stop "/etc/init.d/postgresql stop"
end
```

Default action is `:enable`. You can disable by doing

```ruby
monit "postgresql" do
    ...
    action :disable
end
```

Here's a little more complicated one

```ruby
monit "sidekiq" do
  pidfile "/app/pids/sidekiq.pid"
  start "/app/bin/sidekiq --pidfile /app/pids/sidekiq.pid"
  uid "deployer"
  gid "admin"
  conditions [
    "if mem > 256 MB for 1 cycles then restart",
    "if cpu > 90% for 5 cycles then restart",
    "if 5 restarts within 5 cycles then timeout"
  ]
end    
```

Notice that `stop` is not set. If `stop` is not set, the provider will use a `SIGTERM` to kill the `pid`. 

License
=======

Author:: James Hu (<axsuul@gmail.com>)

Copyright:: Copyright (c) 2012, James Hu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
