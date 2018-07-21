dep 'karabiner preferences.plist' do
  requires 'karabiner.cask'

  target '~/Library/Preferences/org.pqrs.Karabiner.plist'
  entries [
    {
      :path => ":kIsOverwriteKeyRepeat",
      :type => 'bool',
      :value => 'true'
    }
  ]
end

dep 'karabiner repeat wait.karabinersetting' do
  requires 'karabiner preferences.plist'

  setting 'repeat.wait'
  value '10'
end

dep 'karabiner repeat initial wait.karabinersetting' do
  requires 'karabiner preferences.plist'

  setting 'repeat.initial_wait'
  value '50'
end

dep 'karabiner remap uk keyboard to sane layout.karabinertoggle' do
  requires 'karabiner preferences.plist'

  setting 'remap.uk_saneuklayout'
  enabled true
end

dep 'karabiner remap Fn-FN to functional.karabinertoggle' do
  requires 'karabiner preferences.plist'

  setting 'remap.fnF1_F12_to_functional'
  enabled true
end

dep 'karabiner remap FN to plain FN.karabinertoggle' do
  requires 'karabiner preferences.plist'

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
  requires 'karabiner preferences.plist'
  requires 'karabiner.loginitem'
  requires 'karabiner repeat wait.karabinersetting'
  requires 'karabiner repeat initial wait.karabinersetting'
  # requires 'karabiner remap uk keyboard to sane layout.karabinertoggle'
end
