dep 'dropbox.loginitem' do
  name "Dropbox"
  hidden false
  path "/Applications/Dropbox.app".p.cleanpath
end

dep 'dropbox credentials' do
  met? {
    '~/.dropbox/info.json'.p.exist?
  }

  meet {
    confirm("Log in to Dropbox. Hit return when complete.")
  }
end

dep 'dropbox' do
  requires 'dropbox.cask'
  requires 'dropbox credentials'
  requires 'dropbox.loginitem'
end
