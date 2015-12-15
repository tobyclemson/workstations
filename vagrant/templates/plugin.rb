meta 'vagrantplugin' do
  accepts_value_for :name

  template {
    requires_when_unmet 'vagrant.cask'

    met? {
      shell?("vagrant plugin list | grep #{name}")
    }

    meet {
      shell("vagrant plugin install #{name}")
    }
  }
end
