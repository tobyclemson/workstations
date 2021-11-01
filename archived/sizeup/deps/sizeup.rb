dep 'sizeup license.file' do
  requires 'sizeup.cask'
  requires 'gnupg.brew'

  def license_plist
    GpgHelper.decrypt('sizeup/files/license.gpg')
  end

  content license_plist
  target '~/Library/Application Support/SizeUp/SizeUp.sizeuplicense'
end

dep 'sizeup.loginitem' do
  name "SizeUp"
  hidden false
  path "/Applications/SizeUp.app"
end

dep 'sizeup' do
  requires 'sizeup.cask'
  requires 'sizeup license.file'
  requires 'sizeup.loginitem'
end
