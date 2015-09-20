dep 'karabiner repeat wait.karabinersetting' do
  setting 'repeat.wait'
  value '10'
end

dep 'karabiner repeat initial wait.karabinersetting' do
  setting 'repeat.initial_wait'
  value '50'
end

dep 'karabiner remap uk keyboard to sane layout.karabinertoggle' do
  setting 'remap.uk_saneuklayout'
  enabled true
end

dep 'karabiner remap Fn-FN to functional.karabinertoggle' do
  setting 'remap.fnF1_F12_to_functional'
  enabled true
end

dep 'karabiner remap FN to plain FN.karabinertoggle' do
  setting 'remap.functional2fn_2008'
  enabled true
end

dep 'karabiner.loginitem' do
  requires 'karabiner.cask'

  name "Karabiner"
  hidden false
  path "/Applications/Karabiner.app"
end

dep 'karabiner' do
  requires 'karabiner.cask'
  requires 'karabiner.loginitem'
  requires 'karabiner repeat wait.karabinersetting'
  requires 'karabiner repeat initial wait.karabinersetting'
  requires 'karabiner remap uk keyboard to sane layout.karabinertoggle'
end
