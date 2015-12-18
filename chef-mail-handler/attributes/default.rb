default[:mail_handler] = {
  :to_address => "root",
  :from_address => "chef-client@#{node.hostname}",
  :send_statuses => ["Successful", "Failed"],
  :hostname => node.hostname,
  :enable => true,
  :via => nil,
  :via_options => nil
}
