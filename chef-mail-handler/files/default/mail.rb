# Copyright:: 2011, Mathieu Sauve-Frankel <msf@kisoku.net>
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

require 'rubygems'
require 'chef'
require 'chef/handler'
require 'erubis'
require 'pony'

class MailHandler < Chef::Handler
  attr_reader :options
  def initialize(opts = {})
    @options = {
      :to_address => "root",
      :from_address => "chef-client",
      :send_statuses => ["Successful", "Failed"],
      :template_path => File.join(File.dirname(__FILE__), "mail.erb"),
      :hostname => 'local'
    }
    @options.merge! opts
  end

  def report
    status = success? ? "Successful" : "Failed"
    if options[:send_statuses].include? status
      from_address = (options[:from_address] == 'chef-client') ? "#{options[:from_address]}@#{node.fqdn}" : options[:from_address]
      hostname = (options[:hostname] == 'local') ? node.fqdn : options[:hostname]

      subject = "#{status} Chef run on node #{hostname}"

      Chef::Log.debug("mail handler template path: #{options[:template_path]}")
      if File.exists? options[:template_path]
        template = IO.read(options[:template_path]).chomp
      else
        Chef::Log.error("mail handler template not found: #{options[:template_path]}")
        raise Errno::ENOENT
      end

      context = {
        :status => status,
        :run_status => run_status,
        :hostname => hostname
      }

      body = Erubis::Eruby.new(template).evaluate(context)

      pony_options = {
        :to => options[:to_address],
        :from => from_address,
        :subject => subject,
        :body => body
      }
      pony_options[:via] = options[:via] if options[:via]
      pony_options[:via_options] = options[:via_options] if options[:via_options]

      Pony.mail(pony_options)
    end
  end
end