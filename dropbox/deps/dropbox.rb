dep 'dropbox.loginitem' do
  name "Dropbox"
  hidden false
  path shell("readlink '#{'~/Applications/Dropbox.app'.p.cleanpath}'")
end

dep 'dropbox credentials' do
  met? {
    '~/.dropbox/info.json'.p.exist?
  }

  meet {
    shell("echo 'Log in to Dropbox. Hit return when complete.'; read")
  }
end

dep 'dropbox' do
  requires 'dropbox.cask'
  requires 'dropbox credentials'
  requires 'dropbox.loginitem'
end
