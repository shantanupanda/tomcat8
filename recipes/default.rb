#
# Cookbook Name:: tomcat8
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'javaw'

if node['tomcat']['base_version'].to_i < 8
include_recipe 'tomcat::default'

else

group "tomcat" do
append true
end 

user "tomcat" do
  comment "apache tomcat system account"
  shell node['tomcat8']['shell']
  password node['tomcat8']['password']
  group 'tomcat'
end

directory "#{node['tomcat8']['installation_directory']}/tomcat" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file "#{node['tomcat8']['installation_directory']}/apache-tomcat-#{node['tomcat']['base_version']}.tar.gz" do
  source node['tomcat8']['tomcat_url']
  checksum node['tomcat8']['checksum']
  owner 'tomcat'
end

bash "extract_tomcat" do
  user 'root'
  cwd node['tomcat8']['installation_directory']
  code <<-EOH
    tar -zxvf "apache-tomcat-#{node['tomcat']['base_version']}.tar.gz" -C /opt/tomcat --strip-components=1
  EOH
end

bash "change ownership of the extracted apache directory to tomcat" do
  user 'root'
  cwd "#{node['tomcat8']['installation_directory']}/tomcat"
  code <<-EOH
    sudo chgrp -R tomcat conf
    sudo chmod g+rwx conf
    sudo chmod g+r conf/*
    sudo chown -R tomcat webapps/ work/ temp/ logs/
  EOH
end

#template '/etc/init/tomcat.conf' do
 # source 'tomcat8_upstart.erb'
 # owner 'root'
 # group 'root'
 # mode '0755'
#end

bash "start_tomcat" do
  user 'root'
  cwd "#{node['tomcat8']['installation_directory']}/tomcat"
  code <<-EOH
#  curl localhost:8080 > /dev/null 2&>1
#   sudo initctl reload-configuration
#   sudo initctl start tomcat
    sudo ./bin/startup.sh
EOH
end

end
