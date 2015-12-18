# chef-mail-handler cookbook

This is a wrapper cookbook to setup and run the [chef-mail-handler gem](http://github.com/kisoku/chef-handler-mail) with pull requests from:

* [aaronblyth](http://github.com/kisoku/chef-handler-mail/pull/3)
* [trobock](http://github.com/kisoku/chef-handler-mail/pull/5)

This manually installs the mail handler.  If the maintainers update the gem, I'll change the recipe to use the chef_gem. Also, if either pull requests mentioned above do not want their changes included here I will remove them.

In addtion, I've added custom hostname support.

# Requirements

This has been tested on centos and amazon.

* [chef-client](http://github.com/opscode-cookbooks/chef-client) cookbook
* [chef-handler](http://github.com/opscode-cookbooks/chef-handler) cookbook

# Usage

1. Set the `node[:mail_handler][:to_address]` attribute.
2. Run the default recipe early on in your chef run (preferably right after the chef-client cookbook).

# Attributes

name | description | type | default
--- | --- | --- | ---
`:to_address` | email address to send to. |  string, array | root
`:from_address` | email address to send from. |  string | chef-client@node.fqdn
`:send_statuses` | which statuses to trigger email | string, array | ["Successful", "Failed"]
`:hostname` | a custom hostname | string | node.fqdn
`:enable` | enable handler | bool | true
`:via` | Type of transport to send email | string | nil
`:via_options` | Transport's options | hash | nil

# Recipes

default - adds the necessary files and runs the chef-handler lwrp.

# Author

Author:: Table XI (<sysadmins@tablexi.com>)
