#
# Cookbook Name:: my-vagrant-development
# Recipe:: default
#
# Copyright (C) 2014 Marcel Becker
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "ssh_known_hosts"

#dist = node['emacs24']['use_unstable'] == true ? "unstable/" : "oldstable/"

ssh_known_hosts_entry 'github.com'
ssh_known_hosts_entry 'svn.kestrel.edu'
ssh_known_hosts_entry 'stash.kestrel.edu'
ssh_known_hosts_entry 'localhost'
ssh_known_hosts_entry 'github-enterprise.px.ftw'



#apt_repository "emacs24" do
#  uri "http://emacs.naquadah.org/"
#  distribution dist
#  key "http://emacs.naquadah.org/key.gpg"
#  deb_src true
#end

# apt_repository "emacs24" do
#   uri "http://ppa.launchpad.net/cassou/emacs/ubuntu"
#   distribution "precise"
#   components ["main"]
#   key "84DBCE2DCEC45805"
#   keyserver "keyserver.ubuntu.com"
# end

# apt_repository "gnome" do
#   uri "http://ppa.launchpad.net/gnome3-team/gnome3-staging/ubuntu"
#   distribution node['lsb']['codename'] #"precise"
#   components ["main"]
#   key "3B1510FD"
#   keyserver "keyserver.ubuntu.com"
# end

apt_repository "gnome-themes" do
  uri "http://ppa.launchpad.net/upubuntu-com/gtk3/ubuntu"
  distribution  "precise"
  components ["main"]
  key "E06E6293"
  keyserver "keyserver.ubuntu.com"
end

apt_repository "gnome-themes-3-6" do
  uri "http://ppa.launchpad.net/upubuntu-com/gtk+3.6/ubuntu"
  distribution  "precise"
  components ["main"]
  key "E06E6293"
  keyserver "keyserver.ubuntu.com"
end

apt_repository "xfce-theme_manager" do
  uri "http://ppa.launchpad.net/rebuntu16/other-stuff/ubuntu"
  distribution node['lsb']['codename'] #"precise"
  components ["main"]
  key "191A0DD498F78EB3"
  keyserver "keyserver.ubuntu.com"
end

apt_repository "ubuntu-app-indicator" do
  uri "http://ppa.launchpad.net/atareao/atareao/ubuntu"
  distribution node['lsb']['codename'] #"precise"
  components ["main"]
  key "36FD5529"
  keyserver "keyserver.ubuntu.com"
end

apt_repository "sublime-text-2" do
  uri "http://ppa.launchpad.net/webupd8team/sublime-text-2/ubuntu"
  distribution node['lsb']['codename'] #"precise"
  components ["main"]
  key "EEA14886"
  keyserver "keyserver.ubuntu.com"
end





# apt_repository "java" do
#   uri "http://ppa.launchpad.net/webupd8team/java/ubuntu"
#   distribution "precise"
#   components ["main"]
#   key "EEA14866"
#   keyserver "keyserver.ubuntu.com"
# end




#execute "Accept_Oracle_License" do
#command "echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections"
#action :run
#end

#execute "Add_Java_APT_Repo" do
#command "add-apt-repository  -y ppa:webupd8team/java && apt-get -y update"
#action :run
#end


#package "emacs24"
#package "emacs24-el"
#package "emacs24-common-non-dfsg"
#package "ubuntu-desktop"
#package "xubuntu-desktop"
#package "ubuntu-gnome-desktop"
package "build-essential"
package "linux-headers-generic"
package "synaptic"
package "unity"
package "unity-tweak-tool"
#package "gnome-shell"
#package "gnome-panel"
#package "gdm"
package "xfce4"
package "make"
package "cmake"
package "xfce-theme-manager"
package "libgtk2.0-dev"
package "gtk-chtheme"
package "docker"
package "docker.io"
package "cairo-dock"
package "vim-gtk"
package "compizconfig-settings-manager"
package "compiz-plugins-extra"
package "terminator"
package "xfwm4-composite-editor"
package "xfwm4-themes"
package "gnome-tweak-tool"
#package "gnome-shell-extensions"
package "elementary"
package "zukitwo"
package "zukiwi"
package "elegant-brit-theme"
package "gnomishgray"
package "drakfire-zuki"
package "delorean-noir-theme"
package "ice-cream-theme"
package "light-greyness-dark-grey"
package "ice-redux"
package "oceanic-dark"
package "mediterranean-night-themes"
package "thewidgetfactory"
package "calendar-indicator"
package "sublime-text"
package "python-software-properties"
package "ipython"
#package "virtualbox-guest-dkms"
#package "virtualbox-guest-utils"
#package "virtualbox-guest-x11"

package "maven"
package "libsnappy-dev"
package "python-pip"
package "libssl-dev"
package "openjdk-7-jdk"
package "ansible"
package "python-apt"
package "lua5.2"
package "liblua5.2-0"
package "liblua5.2-dev"


remote_file "luarocks distribution, v. 2.1.2" do
  path   "#{Chef::Config[:file_cache_path]}/luarocks-2.1.2.tar.gz"
  source "http://luarocks.org/releases/luarocks-2.1.2.tar.gz"
  not_if { ::File.exists? "#{Chef::Config[:file_cache_path]}/luarocks-2.1.2.tar.gz" }
end

execute "Unpack luarocks distribution" do
  cwd     Chef::Config[:file_cache_path]
  command "tar xzf #{Chef::Config[:file_cache_path]}/luarocks-2.1.2.tar.gz"
  not_if  { ::File.directory? "#{Chef::Config[:file_cache_path]}/luarocks-2.1.2" }
end

bash "Compile luarocks" do
  cwd "#{Chef::Config[:file_cache_path]}/luarocks-2.1.2"

  code <<-EOH
    set -x
    exec >  /var/tmp/chef-luarocks-compile.log
    exec 2> /var/tmp/chef-luarocks-compile.log
    ./configure
    make
    make install
  EOH

  not_if { ::File.exists? "/usr/local/bin/luarocks" }
end


#package "oracle-java7-installer"
#package "oracle-java7-set-default"

script "install_docker" do
   interpreter "bash"
   user "root"

   code <<-EOH
ln -sf /usr/bin/docker.io /usr/local/bin/docker
sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
   EOH
end

include_recipe "emacs24-ppa"
include_recipe "java"
include_recipe "my-vagrant-development::dropbox"
include_recipe "google-chrome"



#node.default['eclipse']['version'] = 'luna'
#node.default['eclipse']['release_code'] = 'R'
#node.default['eclipse']['suite'] = 'rcp'
#node.default['eclipse']['url'] = "http://developer.eclipsesource.com/technology/epp/luna/eclipse-rcp-luna-R-linux-gtk-x86_64.tar.gz""

#include_recipe "eclipse"


 eclipse_mirror_site = "http://developer.eclipsesource.com/technology/epp/luna"
 eclipse_file = "eclipse-rcp-luna-R-linux-gtk-x86_64.tar.gz"
 script "install_eclipse" do
   interpreter "bash"
   user "root"
   cwd "/tmp/"
   code <<-EOH
   rm -rf /opt/eclipse
   wget #{eclipse_mirror_site}/#{eclipse_file}
   tar -zxvf #{eclipse_file}
   cp -r eclipse /opt
   cd /usr/local/bin
   ln -fs /opt/eclipse/eclipse
   EOH
   only_if do ! File.exists?("/opt/eclipse/eclipse") end
 end

 script "install_eclipse_icon" do
   interpreter "bash"
   user "root"
   cwd "/tmp/"
   code <<-EOH
 touch eclipse-desktop
 echo "[Desktop Entry]
                 Name=Eclipse
                 Type=Application
                 Exec=/opt/eclipse/eclipse
                 Terminal=false
                 Icon=/opt/eclipse/icon.xpm
                 Comment=Integrated Development Environment
                 NoDisplay=false
                 Categories=Development;IDE
                 Name[en]=eclipse.desktop" >> eclipse-desktop
 mv eclipse-desktop /usr/share/applications/eclipse.desktop
   EOH
   only_if do ! File.exists?("/usr/share/applications/eclipse.desktop") end
 end

script "install_all_dot_files" do
    interpreter "bash"
    user "vagrant"
    group "vagrant"
    cwd "/home/vagrant"
    environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
    only_if do File.exists?("/vagrant/home/Dropbox") &&  ! File.exists?("/home/vagrant/Dropbox") end
    code <<-EOH
echo "Starting to run the bash shell script"
mkdir /home/vagrant/Dropbox
cp -r /vagrant/home/Dropbox/.emacs.d /home/vagrant/Dropbox/
cp -r /vagrant/home/.emacs.d /home/vagrant/
cp -r /vagrant/home/.bash* /home/vagrant/
cp -r /vagrant/home/.git* /home/vagrant/
   EOH
 end


# sbcl_file = "http://downloads.sourceforge.net/project/sbcl/sbcl/1.1.10/sbcl-1.1.10-x86-64-linux-binary.tar.bz2"
# script "install_sbcl" do
#   interpreter "bash"
#   user "root"
#   cwd "/tmp/"
#   code <<-EOH
#   wget #{sbcl_file}
#   bzip2 -cd sbcl-1.1.10-x86-linux-binary.tar.bz2 | tar xvf -
#   cd sbcl-1.1.10-x86-linux
#   sh install.sh
#   EOH
#   only_if do ! File.exists?("/usr/local/bin/sbcl") end
# end


#directory node[:planware][:home] do
 # owner node[:planware][:user]
  # group node[:planware][:group]
#   mode "0755"
#   action :create
# end

# directory node[:planware][:src_dir] do
#   owner node[:planware][:user]
#   group node[:planware][:group]
#   mode "0755"
#   action :create
# end

# template "/home/#{node[:planware][:user]}/.ssh/config" do
#   source "ssh.config.erb"
#   owner node[:planware][:user]
#   group node[:planware][:group]
#   mode "0644"
# end



# class Chef
#   class Recipe
#     # Modified version of HomesickCastle#run to support agent forwarding, by
#     # using 'ssh user@localhost COMMAND' instead of 'sudo -u user COMMAND'
#     def run_with_agent(command)

#       #enable ssh agent forwarding
#       ssh_options = "-A"

#       # Avoid 'Host key verification failed' error related to not having localhost in /root/.ssh/known_hosts
#       ssh_options << " -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

#       # PATH setting prevents "homesick: command now found" error, possibly related to
#       # a Vagrant path bug: https://github.com/mitchellh/vagrant/issues/1013
#       cmd_prefix = 'PATH=$PATH:/opt/vagrant_ruby/bin'

#       # command = 'ssh-add -l & false' # really useful for debugging

#       remote_command = "ssh #{ssh_options} #{new_resource.user}@localhost '#{cmd_prefix} #{command}'"
#       execute remote_command
#     end
#   end
# end
#svn_command ="svn co svn+ssh://svn@svn.kestrel.edu/Specware/trunk"

#run_with_agent(svn_command)


# execute "Checkout Specware" do
# command "ssh -A  -o UserKnownHostsFile=/etc/ssh/ssh_known_hosts -o StrictHostKeyChecking=no planware@localhost 'PATH=$PATH:/opt/vagrant_ruby/bin svn co svn+ssh://svn@svn.kestrel.edu/Specware/trunk /home/planware/src/specware'"
# action :run
# end


# subversion "/home/planware/src/specware" do
#   repository "svn+ssh://svn@svn.kestrel.edu/Specware/trunk"
#   revision "HEAD"
#   destination "/home/planware/src/specware"
#   action :checkout
#   user "planware"
# end

# git "/home/planware/src/planware" do
#   repository "ssh://git@stash.kestrel.edu:2222/PLW/planware.git"
#   reference "master"
#   destination "/home/planware/src/planware"
#   action :checkout
# end
