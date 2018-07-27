dep 'karabiner-elements.loginitem' do
  requires 'karabiner-elements.cask'

  name "Karabiner Elements"
  hidden false
  path "/Applications/Karabiner-Elements.app"
end

dep 'karabiner-config.file' do
  source "#{__FILE__.p.parent}/../files/karabiner.json"
  target '~/.config/karabiner/karabiner.json'
end

dep 'karabiner-elements' do
  requires 'karabiner-elements.cask'
  requires 'karabiner-elements.loginitem'
  requires 'karabiner-config.file'
end
