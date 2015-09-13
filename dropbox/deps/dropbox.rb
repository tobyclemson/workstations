dep 'dropbox.loginitem' do
  name "Dropbox"
  hidden false
  path shell("readlink '#{'~/Applications/Dropbox.app'.p.cleanpath}'")
end

dep 'dropbox' do
  requires 'dropbox.cask'
  requires 'dropbox.loginitem'
end
