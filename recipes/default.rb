#
# Cookbook Name:: my-vagrant-development
# Recipe:: default
#
# Copyright (C) 2014 Marcel Becker
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "python"
include_recipe "chef-solo-search"

# To get vbox resolution to work correctly you need to re-install the vbgues
# add a cd rom storage to your machine. In the vbox settings, add an ide controller
# and add a cd disk.
# If the mount is not successful, try this:
# mount /dev/cdrom /mnt
# cd /mnt
# ./VBoxLinuxAdditions.run
# reboot



#dist = node['emacs24']['use_unstable'] == true ? "unstable/" : "oldstable/"
# include_recipe "ssh_known_hosts"
# ssh_known_hosts_entry 'github.com'
# ssh_known_hosts_entry 'svn.kestrel.edu'
# ssh_known_hosts_entry 'stash.kestrel.edu'
# ssh_known_hosts_entry 'localhost'
# ssh_known_hosts_entry 'github-enterprise.px.ftw'



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

# use openssl passwd -1 "theplaintextpassword"
# to generate password
include_recipe 'user'
user_account 'becker' do
    shell '/bin/bash'
    ssh_keygen 'true'
    password '$1$qGG/CvFp$gA32u2fe0yt52GyVsehQ2/'
    #create_group 'becker'
    #gid 'becker'
    home '/home/becker'
    manage_home true
    action :create
end


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

apt_repository "x2go-repo" do
  uri "http://ppa.launchpad.net/x2go/stable/ubuntu"
  distribution node['lsb']['codename'] #"precise"
  components ["main"]
  key "0A53F9FD"
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

package "xubuntu-desktop"
#package "ubuntu-gnome-desktop"
package "build-essential"
package "linux-headers-generic"
package "synaptic"
package "xfce4"
package "xfce-theme-manager"
#package "gnome-shell"
#package "gnome-panel"
#package "gdm"

package "make"
package "cmake"

package "libgtk2.0-dev"
package "gtk-chtheme"
#package "docker"
#package "docker.io"
#package "cairo-dock"
package "vim-gtk"
package "compizconfig-settings-manager"
package "compiz-plugins-extra"
package "terminator"
#package "xfwm4-composite-editor"
package "xfwm4-themes"
package "gnome-tweak-tool"
#package "gnome-shell-extensions"

#package "unity"
#package "unity-tweak-tool"
#package "unity8"
#package "ubuntu-desktop"

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
#package "python-software-common"
package "ipython"
package "msgpack-python"
#package "virtualbox-guest-dkms"
#package "virtualbox-guest-utils"
#package "virtualbox-guest-x11"

package "scapy"
package "python-twisted"
package "python-boto"
package "python-zodb"
package "bridge-utils"

script "download_and_install_pip_with_easy_install" do
    cwd Chef::Config[:file_cache_path]
   interpreter "bash"
   user "root"
   code <<-EOH
easy_install --upgrade pip
   EOH
   not_if { ::File.exists? "/usr/local/bin/pip" }
end

script "download_and_install_maven" do
    cwd Chef::Config[:file_cache_path]
   interpreter "bash"
   user "root"
   code <<-EOH
apt-get purge -y maven
rm -rf /usr/bin/mvn
#apt-add-repository -y -rm ppa:natecarlson/maven3
#apt-get update
#apt-get install maven

wget http://apache.cs.utah.edu/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar -zxf apache-maven-3.3.9-bin.tar.gz -C /usr/share
#cp -R apache-maven-3.3.9 /usr/local
ln -s /usr/share/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
echo "export M2_HOME=/usr/share/apache-maven-3.3.9" >> ~becker/.bashrc
   EOH
end



package "libsnappy-dev"
package "python-pip"
package "libssl-dev"
#package "openjdk-7-jdk"
package "ansible"
package "python-apt"
package "virtualenv"
#package "lua5.2"
#package "liblua5.2-0"
#package "liblua5.2-dev"

package "x2goserver"
package "x2goserver-xsession"
package "x2goclient"

package "apt-transport-https"
package "ca-certificates"

python_pip "gunicorn"
python_pip "twisted"
python_pip "virtualenvwrapper"



#remote_file "luarocks distribution, v. 2.1.2" do
#  path   "#{Chef::Config[:file_cache_path]}/luarocks-2.2.0.tar.gz"
#  source "http://luarocks.org/releases/luarocks-2.2.0.tar.gz"
#  not_if { ::File.exists? "#{Chef::Config[:file_cache_path]}/luarocks-2.2.0.tar.gz" }
#end

#execute "Unpack luarocks distribution" do
#  cwd     Chef::Config[:file_cache_path]
#  command "tar xzf #{Chef::Config[:file_cache_path]}/luarocks-2.2.0.tar.gz"
#  not_if  { ::File.directory? "#{Chef::Config[:file_cache_path]}/luarocks-2.2.0" }
#end

#bash "Compile luarocks" do
#  cwd "#{Chef::Config[:file_cache_path]}/luarocks-2.2.0"
#  code <<-EOH
#    set -x
#    exec >  /var/tmp/chef-luarocks-compile.log
#    exec 2> /var/tmp/chef-luarocks-compile.log
#    ./configure
#    make
#    make install
#  EOH
#  not_if { ::File.exists? "/usr/local/bin/luarocks" }
#end


#package "oracle-java7-installer"
#package "oracle-java7-set-default"

script "download_and_install_virtualbox" do
    cwd Chef::Config[:file_cache_path]
   interpreter "bash"
   user "root"
   code <<-EOH
#apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian vivid contrib"
#wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
#apt-get update
#apt-get install dkms
#apt-get install -y virtualbox-5.0
apt-get install -y virtualbox
   EOH
end

script "download_and_install_docker" do
    cwd Chef::Config[:file_cache_path]
   interpreter "bash"
   user "root"
   code <<-EOH
apt-get install linux-image-extra-$(uname -r) -y
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo deb https://apt.dockerproject.org/repo ubuntu-wily main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install docker-engine -y
#curl -sSL https://get.docker.io/ubuntu/ | sudo sh
   EOH
   only_if do ! File.exists?("/usr/bin/docker") end
end

# script "link_docker_file" do
#     cwd Chef::Config[:file_cache_path]
#    interpreter "bash"
#    user "root"
#    code <<-EOH

# ln -sf /usr/bin/docker.io /usr/local/bin/docker
#    EOH
#    only_if { ::File.exists? "/usr/bin/docker.io" }
# end


script "add_vagrant_user_to_docker_group" do
    cwd Chef::Config[:file_cache_path]
   interpreter "bash"
   user "root"
   code <<-EOH
groupadd docker
gpasswd -a vagrant docker
gpasswd -a becker docker
   EOH
end

script "add_becker_user_to_sudoers" do
   interpreter "bash"
   user "root"
   only_if do ! File.exists?("/etc/sudoers.d/becker") end
   code <<-EOH
echo 'becker ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/becker
chmod 0440 /etc/sudoers.d/becker
   EOH
end

#include_recipe "emacs24-ppa"
#include_recipe "java"
include_recipe "rspace-vagrant::dropbox"
include_recipe "google-chrome"

#node.default['eclipse']['version'] = 'luna'
#node.default['eclipse']['release_code'] = 'R'
#node.default['eclipse']['suite'] = 'rcp'
#node.default['eclipse']['url'] = "http://developer.eclipsesource.com/technology/epp/luna/eclipse-rcp-luna-R-linux-gtk-x86_64.tar.gz""

#include_recipe "eclipse"


#bash "install_lua_busted" do
#   user "root"
#   code <<-EOH
#luarocks install busted
#   EOH
#end

# bash "install_lua_libreadline_dev" do
#    user "root"
#    code <<-EOH
# luarocks install libreadline-dev
#    EOH
# end

#bash "install_lua_luasocket" do
#   user "root"
#   code <<-EOH
#luarocks install luasocket
#   EOH
#end

#bash "install_lua_copas" do
#   user "root"
#   code <<-EOH
#luarocks install copas
#   EOH
#end

#bash "install_lua_copastimer" do
#   user "root"
#   code <<-EOH
#luarocks install copastimer
#   EOH
#end

#bash "install_lua_uuid" do
#   user "root"
#   code <<-EOH
#luarocks install uuid
#   EOH
#end

#bash "install_lua_messagepack" do
#   user "root"
#   code <<-EOH
#luarocks install lua-messagepack
#   EOH
#end

 script "install_java_and_git" do
   interpreter "bash"
   user "root"
   cwd "/tmp/"
   code <<-EOH
add-apt-repository ppa:git-core/ppa
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install -y git curl
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install -y oracle-java8-installer git
apt-get clean && apt-get autoclean -y && apt-get autoremove -y
   EOH
   only_if do ! File.exists?("/opt/eclipse/eclipse") end
 end

##http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/2/eclipse-jee-mars-2-win32-x86_64.zip
 eclipse_mirror_site = "http://developer.eclipsesource.com/technology/epp/mars"
 eclipse_file = "eclipse-rcp-mars-R-linux-gtk-x86_64.tar.gz"
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


# script "install_all_dot_files" do
#     interpreter "bash"
#     #user "becker"
#     #group "becker"
#     cwd "/home/becker"
#     #environment ({'HOME' => '/home/becker', 'USER' => 'becker'})
#     only_if do File.exists?("/home/vagrant/home/Dropbox") &&  ! File.exists?("/home/becker/Dropbox") end
#     code <<-EOH
# echo "Starting to run the bash shell script"
# mkdir /home/becker/Dropbox
# cp -r /home/vagrant/home/Dropbox/.emacs.d /home/becker/Dropbox/
# cp -r /home/vagrant/home/.emacs.d /home/becker/
# cp -r /home/vagrant/home/.bash* /home/becker/
# cp -r /home/vagrant/home/.git* /home/becker/
# cp -r /home/vagrant/home/Dropbox/Linux_Config/Home/becker/.* /home/becker/
# cd /home/becker
# chown -R becker:becker *
# chown -R becker:becker .*
#    EOH
#  end





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


script "install_emacs24_from_source" do
   interpreter "bash"
   user "root"
   cwd "/tmp/"
   code <<-EOH
cd /tmp
mkdir emacs-src && cd emacs-src
wget http://mirror.team-cymru.org/gnu/emacs/emacs-24.5.tar.gz
tar xvf emacs-24.5.tar.gz
apt-get build-dep emacs24 -y
cd emacs-24.5
./configure
make
make install
   EOH
   only_if do ! File.exists?("/usr/local/bin/emacs-24.5") end
 end

script "install_emacs24_desktop_launcher" do
   interpreter "bash"
   user "root"
   cwd "/tmp/"
   code <<-EOH
cat > /usr/share/applications/Emacs-24.desktop << EOF
[Desktop Entry]
Version=1.0
Name=Emacs-24
Exec=env UBUNTU_MENUPROXY=0 /usr/local/bin/emacs
Terminal=false
Icon=emacs
Type=Application
Categories=IDE
X-Ayatana-Desktop-Shortcuts=NewWindow
[NewWindow Shortcut Group]
Name=New Window
TargetEnvironment=Unity
EOF
   EOH
   only_if do ! File.exists?("/usr/share/applications/Emacs-24.desktop") end
 end




script "install_all_dot_files" do
    interpreter "bash"
    user "becker"
    group "becker"
    cwd "/home/becker"
    environment ({'HOME' => '/home/becker', 'USER' => 'becker'})
    only_if do File.exists?("/home/becker/home/Dropbox") &&  ! File.exists?("/home/becker/Dropbox") end
    code <<-EOH
echo "Starting to run the bash shell script"
echo "mkdir /home/becker/Dropbox"
mkdir /home/becker/Dropbox
echo "cp -r /home/becker/home/Dropbox/.emacs.d /home/becker/Dropbox/"
cp -r /home/becker/Dropbox/.emacs.d /home/becker/Dropbox/
echo "cp -r /home/becker/home/.emacs.d /home/becker/"
cp -r /home/becker/home/.emacs.d /home/becker/
echo "cp -r /home/becker/home/.bash* /home/becker/"
cp -r /home/becker/home/.bash* /home/becker/
echo "cp -r /home/becker/home/.git* /home/becker/"
cp -r /home/becker/home/.git* /home/becker/
echo "cp -r /home/becker/home/Dropbox/Linux_Config/Home/becker/.config /home/becker/"
cp -r /home/becker/home/Dropbox/Linux_Config/Home/becker/.config /home/becker/
echo "export M2_HOME=/usr/share/apache-maven-3.3.9" >> /home/becker/.bashrc
   EOH
 end
