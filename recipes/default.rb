#
# Cookbook Name:: tomcat8
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

if node['tomcat']['base_version'].to_i < 8
include_recipe 'tomcat::default'

else
user "tomcat" do
  comment "apache tomcat system account"
  shell node['tomcat8']['shell']
  password node['tomcat8']['password']
end

remote_file "#{node['tomcat8']['installation_directory']}/#{node['tomcat']['base_version']}.tar.gz" do
  source node['tomcat8']['tomcat_url']
  checksum node['tomcat8']['checksum']
  owner 'tomcat'
end

bash "extract_tomcat" do
  user 'root'
  cwd node['tomcat8']['installation_directory']
  code <<-EOH
  if [ -d "#{node['tomcat']['base_version']}" ]; then
    echo 'The tomcat target directory has already been extracted'
  else
    tar -xvzf "#{node['tomcat']['base_version']}.tar.gz"
  fi
  EOH
end

bash "change ownership of the extracted apache directory to tomcat" do
  user 'root'
  cwd node['tomcat8']['installation_directory']
  code <<-EOH
  chown -R tomcat "#{node['tomcat']['base_version']}"
  EOH
end

bash "start_tomcat" do
  user "tomcat"
  cwd "#{node['tomcat8']['installation_directory']}/#{node['tomcat']['base_version']}/bin"
  code <<-EOH
  curl localhost:8080 > /dev/null 2&>1
  if [ $? == 0 ]; then
    echo 'Tomcat is already running'
  else
    ./catalina.sh start
  fi
  EOH
end

end
