dep 'ssh key', :ssh_dir, :ssh_password do
  ssh_dir.ask("Where do you keep your ssh keys").default!('~/.ssh')
  ssh_password.ask("Passphase to encrypt your SSH key")

  met? {
    (ssh_dir / 'id_rsa.pub').exists? && (ssh_dir / 'id_rsa').exists?
  }

  meet {
    shell "ssh-keygen -t rsa -N #{ssh_password} -f #{ssh_dir}/id_rsa"
  }

  after {
    shell "/usr/bin/ssh-add -K"
  }
end
