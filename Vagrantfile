# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.hostname = "rspace-vagrant"
    config.vm.box = "ubuntu-wily64"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/wily/current/wily-server-cloudimg-amd64-vagrant-disk1.box"
    #config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    #config.vm.box_url = "https://vagrantcloud.com/ubuntu/trusty64/version/1/provider/virtualbox.box"
    config.berkshelf.enabled = true
    config.omnibus.chef_version = :latest
    config.vbguest.auto_update = true

    if ::File.exists?("/home/becker")
        config.vm.synced_folder "/home/becker/src/plan-construction", "/home/becker/src/plan-construction/" , create: true, owner: "becker", group: "becker"
        config.vm.synced_folder "/home/becker/", "/home/vagrant/home/", create: true, owner: "vagrant", group: "vagrant", mount_options: ["dmode=777,fmode=777"]
    elsif ::File.exists?("/Users/marcelbecker")
        config.vm.synced_folder "/Users/marcelbecker/src/rspace", "/home/becker/src/rspace/" , create: true, owner: "becker", group: "becker"
        config.vm.synced_folder "/Users/marcelbecker/src/rspace-eclipse", "/home/becker/src/rspace-eclipse/" , create: true, owner: "becker", group: "becker"
        config.vm.synced_folder "/Users/marcelbecker", "/home/becker/home/", create: true, owner: "becker", group: "becker",  mount_options: ["dmode=777,fmode=777"]
        #config.vm.synced_folder "/Users/marcelbecker/", "/home/vagrant/home/", owner: "vagrant", group: "vagrant",  mount_options: ["dmode=777,fmode=777"]

    end

    config.vm.provision :shell, inline: 'mkdir -p /tmp/vagrant-chef/cookbooks/nodes'

    config.vm.provider :virtualbox do |vb, override|
        vb.gui = true
        vb.customize ["modifyvm", :id, "--memory", "10000"]
        vb.customize ["modifyvm", :id, "--cpus", "8"]
        vb.customize ["modifyvm", :id, "--vram", "40"]
        override.vm.network :private_network, ip: "33.33.33.66"
    end

    # if you want to spin up the planning server on openstack using
    # vagrant, uncomment the following lines and make sure you
    # have your config files ~/.vagrantuser properly set.
    # See instructions on README file.
    #
    #  config.vm.provider :openstack do |os, override|
    #    os.username     = ENV['OS_USERNAME']
    #    os.api_key      = ENV['OS_PASSWORD']
    #    os.tenant       = ENV['OS_TENANT_NAME']
    #    os.endpoint     = "#{ENV['OS_AUTH_URL']}/tokens"
#
    #    os.floating_ip  = "10.8.4.44" #config.user.openstack.floating_ip
    #    os.address_id   = "10.8.4.44" #config.user.openstack.floating_ip
    #
    #    # these must refer to the same key
    #    os.keypair_name = config.user.openstack.keypair_name
    #    override.ssh.private_key_path = File.expand_path(config.user.ssh.private_key_path)
    #
    #    override.vm.box = "openstack-dummy"
    #    override.vm.box_url = "http://repo.px.net/vagrant/#{override.vm.box}.box"
    #
    #    os.user_data    = IO.read(File.join(File.dirname(__FILE__), 'user_data.txt'))
    #    os.server_name  = config.vm.hostname
    #    os.flavor       = 'px.medium'
    #    os.image        = 'ubuntu-server-x64-12.04.3'
    #    os.ssh_username = 'ubuntu'
    #  end

    config.vm.provision :chef_solo do |chef|
        chef.channel = "stable"
        chef.version = '12.10.24'
        chef.json = {
            "java" => {
                "install_flavor" => "oracle",
                "jdk_version" => 8,
                "oracle" => {
                    "accept_oracle_download_terms" => true
                }
            },
            "eclipse" => {
                "release_code" => "SR2",
                "suite" => "rcp"
            }
        }
        chef.add_recipe "rspace-vagrant"
        chef.log_level = :debug
    end
end
