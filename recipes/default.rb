#
# Cookbook Name:: tomcat8
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'
#node.override['tomcat']['base_version'] = '7'
#node.override['tomcat']['packages'] = "tomcat#{node['tomcat']['base_version']}"
include_recipe 'tomcat::default'
