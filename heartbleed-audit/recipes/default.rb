#
# Cookbook Name:: heartbleed-audit
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

if defined? node[:packages][:openssl][:version] && node[:packages][:openssl][:version] < node[:openssl][:req_version]
  control_group 'Heartbleed Audit' do
    control 'OpenSSL Version Check' do

      it 'openssl version should be 1.0.1e-42.el6' do
        expect(package('openssl')).to be_installed.with_version('1.0.1e-42.el6')
      end

    end
  end
end
