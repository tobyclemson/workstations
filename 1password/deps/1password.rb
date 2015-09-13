dep '1password license.file' do
  requires '1password.cask'
  requires 'gpgtools.cask'

  def license_plist
    GpgHelper.decrypt('1password/files/license.gpg')
  end

  content license_plist
  target '~/Library/Application Support/1Password 4/License/License.onepassword-license'
end

dep '1password' do
  requires '1password.cask'
  requires '1password license.file'
end
