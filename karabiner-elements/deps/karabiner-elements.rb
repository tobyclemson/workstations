dep 'karabiner.loginitem' do
  requires 'karabiner.cask'

  name "Karabiner"
  hidden false
  path "/Applications/Karabiner.app"
end

dep 'karabiner' do
  requires 'karabiner.cask'
  requires 'karabiner.loginitem'
  # requires 'karabiner remap uk keyboard to sane layout.karabinertoggle'
end
