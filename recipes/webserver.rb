#
# Cookbook Name:: webapp
# Recipe:: lb
#
# Copyright 2014, Digital Window Limited
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"

web_app "webapp" do
  server_name "webapp"
  server_aliases []
  docroot "/var/www/html/webapp"
  cookbook "apache2"
end
