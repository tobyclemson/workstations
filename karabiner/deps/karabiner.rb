dep 'karabiner repeat wait.karabinersetting' do
  setting 'repeat.wait'
  value '10'
end

dep 'karabiner repeat initial wait.karabinersetting' do
  setting 'repeat.initial_wait'
  value '50'
end

dep 'karabiner.loginitem' do
  requires 'karabiner.cask'

  name "Karabiner"
  hidden false
  path shell("/Applications/Karabiner.app")
end

dep 'karabiner' do
  requires 'karabiner.cask'
  requires 'karabiner.loginitem'
  requires 'karabiner repeat wait.karabinersetting'
  requires 'karabiner repeat initial wait.karabinersetting'
end
