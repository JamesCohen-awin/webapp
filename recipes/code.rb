#
# Cookbook Name:: webapp
# Recipe:: lb
#
# Copyright 2014, Digital Window Limited
#
# All rights reserved - Do Not Redistribute
#

directory "/var/www/html/webapp" do
    owner "root"
    group "root"
    mode 00755
end

cookbook_file "/var/www/html/webapp/phpinfo.php" do
    source "phpinfo.php"
    owner "root"
    group "root"
    mode 00644
end
