dep 'sizeup license.file' do
  requires 'sizeup.cask'
  requires 'gpgtools.cask'

  def license_plist
    GpgHelper.decrypt('sizeup/files/license.gpg')
  end

  content license_plist
  target '~/Library/Application Support/SizeUp/SizeUp.sizeuplicense'
end

dep 'sizeup start at login', :for => :osx do
  met? {
    shell("osascript -e 'tell application \"System Events\" to get every login item whose name is \"SizeUp\"'") =~ /SizeUp/
  }

  meet {
    shell("osascript -e 'tell application \"System Events\" to make login item at end with properties {path:\"/opt/homebrew-cask/Caskroom/sizeup/latest/SizeUp.app\", hidden:false, name:\"SizeUp\"}'
")
  }
end

dep 'sizeup' do
  requires 'sizeup.cask'
  requires 'sizeup license.file'
  requires 'sizeup start at login'
end
