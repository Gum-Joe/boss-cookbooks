#
# Cookbook Name:: nodejs
# Recipe:: nvm
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

# Download nvm

# mkdir
bash 'mkdir' do
  code <<-EOH
    sudo mkdir /download
    EOH
  not_if {File::exists?('/download')}
end

# download
remote_file '/download/nvm.sh' do
  source 'https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh'
  action :create
  not_if {File::exists?('/download/nvm.sh')}
end

# Install nvm
bash 'install_nvm' do
  code <<-EOH
    export NVM_DIR=/nvm
    sudo bash /download/nvm.sh
  EOH
end
