#
# Cookbook Name:: webapp
# Recipe:: lb
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# TODO detect servers depending on environment
backendparams = 'check inter 5000 maxconn 20 rise 1 slowstart 30s weight 100';
servers = [
    'localhost 127.0.0.1:82 ' + backendparams
]

haproxy_lb 'myapp' do
  type 'frontend'
  params({
    'bind' => '0.0.0.0:80',
    'default_backend' => 'myapp-backend'
  })
end

haproxy_lb 'myapp-backend' do
  type 'backend'
  servers servers
  params({
    "balance" => "roundrobin",
    "option" => "httpchk /favicon.ico",
    "http-check" => "disable-on-404"
  })
end

include_recipe "haproxy::default";
