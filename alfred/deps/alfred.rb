dep 'alfred.loginitem' do
  requires 'alfred.cask'

  name "Alfred 4"
  hidden false
  path "/Applications/Alfred\ 4.app".p.cleanpath
end

dep 'alfred' do
  requires 'alfred.cask'
  requires 'alfred.loginitem'
end
