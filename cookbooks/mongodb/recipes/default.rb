#
# Cookbook Name:: mongodb
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Gum-Joe
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


# Add key
include_recipe 'mongodb::repo'

# Install
apt_package ['mongodb']  do
  action :install
end

# Create dir
bash 'env' do
  code <<-EOH
    sudo mkdir -p /data/db
    EOH
  not_if {File::exists?('/data/db')}
end

# Start
service 'mongodb' do
  action :start
end

# source ENV
bash 'env' do
  code <<-EOH
    source /vagrant/vars
    EOH
end

# Set user + password
# Bug reference for #26
# Database needs better security
# Mongo will not set username and password
# And will not create db
# bash 'user' do
#   code <<-EOH
#     mongo --eval 'use Jakhu'
#     mongo Jakhu --eval 'db.addUser(admin, admin);'
#     EOH
# end

# Done!
