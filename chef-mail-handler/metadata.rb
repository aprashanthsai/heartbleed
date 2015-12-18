name             "chef-mail-handler"
maintainer       "Table XI"
maintainer_email "sysadmins@tablexi.com"
license          "Apache 2.0"
description      "Installs/Configures chef-mail-handler gem"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"

depends 'chef-client'
depends 'chef_handler'
