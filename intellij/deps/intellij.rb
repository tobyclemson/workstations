dep 'intellij license.file' do
  requires 'intellij-idea.cask'
  requires 'gpgtools.cask'

  def license
    GpgHelper.decrypt('intellij/files/license.gpg')
  end

  content license
  target '~/Library/Preferences/IntelliJIdea14/idea14.key'
end

dep 'intellij' do
  requires 'intellij-idea.cask'
  requires 'intellij license.file'
end
