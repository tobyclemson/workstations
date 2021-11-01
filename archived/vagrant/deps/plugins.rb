dep 'hostmanager.vagrantplugin' do
  name 'vagrant-hostmanager'
end

dep 'cachier.vagrantplugin' do
  name 'vagrant-cachier'
end

dep 'vagrant-plugins' do
  requires 'hostmanager.vagrantplugin'
  requires 'cachier.vagrantplugin'
end

dep 'vagrant' do
  requires 'vagrant-plugins'
end
