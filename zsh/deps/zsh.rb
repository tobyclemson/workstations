dep 'zsh.shell' do
  requires 'zsh.brew'
end

dep 'zsh as default shell', :username do
  username.default!(shell('whoami'))

  requires 'zsh.brew', 'zshenv fixed', 'zsh.shell'

  met? { shell("sudo su - '#{username}' -c 'echo $SHELL'") == which('zsh') }
  meet { sudo("chsh -s '#{which('zsh')}' #{username}") }
end

dep 'zshenv fixed' do
  on :osx do
    met? { !'/etc/zshenv'.p.exists? && '/etc/zprofile'.p.exists? }
    meet {
      shell 'sudo mv /etc/zshenv /etc/zprofile'
    }
  end
end

dep 'oh my zsh.repo' do
  source 'https://github.com/robbyrussell/oh-my-zsh.git'
  path '~/.oh-my-zsh'
end

dep 'zshrc.file' do
  source "#{__FILE__.p.parent}/../files/zshrc"
  target '~/.zshrc'
end

dep 'default zsh theme.file' do
  requires 'oh my zsh.repo'

  source "#{__FILE__.p.parent}/../files/default.zsh-theme"
  target '~/.oh-my-zsh/custom/default.zsh-theme'
end

dep 'zsh' do
  requires 'nvm.brew'
  requires 'goenv.brew'
  requires 'rbenv.brew'
  requires 'pyenv.brew'
  requires 'direnv.brew'
  requires 'sdkman'
  requires 'phpbrew'
  requires 'zsh as default shell'
  requires 'oh my zsh.repo'
  requires 'zshrc.file'
  requires 'default zsh theme.file'
end
