dep 'intellij license.file' do
  requires 'intellij-idea.cask'
  requires 'gpgtools.cask'

  def license
    GpgHelper.decrypt('intellij/files/license.gpg')
  end

  content license
  target '~/Library/Preferences/IntelliJIdea14/idea14.key'
end

dep 'intellij disabled plugins.file' do
  requires 'intellij-idea.cask'

  source "#{__FILE__.p.parent}/../files/disabled_plugins.txt"
  target '~/Library/Preferences/IntelliJIdea14/disabled_plugins.txt'
end

dep 'intellij' do
  requires 'intellij-idea.cask'
  requires 'intellij license.file'
  requires 'intellij disabled plugins.file'
end
