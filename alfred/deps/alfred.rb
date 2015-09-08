dep 'alfred license file.plist' do
  requires 'alfred.cask'
  
  target "$HOME/Library/Application Support/Alfred 2/license.plist"
end

dep 'alfred' do
  requires 'alfred.cask'
  requires 'alfred license file.plist'
end
