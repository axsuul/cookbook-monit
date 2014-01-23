Description
===========

Provides a set of primitives for managing monit and monit configurations.

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

Installation
============
[Librarian](https://github.com/applicationsonline/librarian) is recommended to install this cookbook. In fact, it's recommended to install all your cookbooks! Within your `Cheffile`

```ruby
cookbook 'monit', git: 'https://github.com/axsuul/cookbook-monit'
```

Recipes
=======

Some monit configuration recipes have also been provided for some popular services.

default
-------

Installs monit as a service using the package manager and drops off a `monitrc` configuration file. Make sure to check out the default attributes file!

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
    # ...
    action :disable
end
```

What happens if you want to run the process as a user? The `monit` resource provides a helper attribute `as` and will load that user's environment while running the `start` and `stop` commands.
```ruby
monit "sidekiq" do
  pidfile "/app/pids/sidekiq.pid"
  start "/app/bin/sidekiq --pidfile /app/pids/sidekiq.pid"
  as "deployer"
  conditions [
    "if mem > 256 MB for 1 cycles then restart",
    "if cpu > 90% for 5 cycles then restart",
    "if 5 restarts within 5 cycles then timeout"
  ]
end
```

You still have the option to run the commands directly as the user (without environment) with `uid` and `gid`, although most likely you will want to use `as`.

```ruby
monit "sidekiq" do
  pidfile "/app/pids/sidekiq.pid"
  uid "deployer"
  gid "admin"
  # ...
end
```

Notice that in the above example, `stop` is not set. If `stop` is not set, the provider will use a `SIGTERM` to kill the pid in the `pidfile`.

**No pidfile?**. No worries bro!

```ruby
monit "varnish" do
  matching "varnishd"
  # ...
end
```

Contributing
============

I love pull requests!

License
=======

Author:: James Hu (<hello@james.hu>)

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
