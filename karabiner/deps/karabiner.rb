dep 'karabiner repeat wait' do
  requires 'karabiner.cask'

  karabiner = '/Applications/Karabiner.app/Contents/Library/bin/karabiner'

  met? {
    shell("#{karabiner} changed | grep repeat.wait | cut -d '=' -f 2") == '10'
  }

  meet {
    shell("#{karabiner} set repeat.wait 10")
  }
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
  requires 'karabiner repeat wait'
end
