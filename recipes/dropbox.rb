case node[:platform]
when "ubuntu","debian"
  apt_repository "dropbox" do
    uri "http://linux.dropbox.com/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "pgp.mit.edu"
    key "5044912E"
  end

  package "python-gpgme"
  package "dropbox"
when "arch"
  include_recipe "pacman"
  pacman_aur "dropbox-daemon"
  pacman_aur "dropbox-cli"
end
