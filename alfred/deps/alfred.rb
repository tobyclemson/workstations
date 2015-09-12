dep 'alfred license file.plist' do
  requires 'alfred.cask'
  requires 'gpgtools.cask'

  def license_code
    GpgHelper.decrypt('alfred/files/license.gpg')
  end
  
  target "~/Library/Application Support/Alfred 2/license.plist"
  entries [
    {
      :path => ":'email'",
      :type => 'string',
      :value => 'tobyclemson@gmail.com'
    },
    {
      :path => ":'code'",
      :type => 'string',
      :value => license_code
    }
  ]
end

dep 'alfred' do
  requires 'alfred.cask'
  requires 'alfred license file.plist'
end
