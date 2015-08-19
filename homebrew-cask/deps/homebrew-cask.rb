dep 'homebrew-cask' do
  requires 'homebrew'

  meet { shell 'brew install caskroom/cask/brew-cask' }
  met? { shell? 'brew cask' }
end
