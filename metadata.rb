name             "monit"
maintainer       "James Hu"
maintainer_email "axsuul@gmail.com"
license          "Apache 2.0"
description      "Provides recipes for installing monit and maintaining monit configurations."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

recipe "monit", "Installs monit"

%w{ubuntu debian}.each do |os|
  supports os
end
