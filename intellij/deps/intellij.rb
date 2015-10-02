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

dep 'ruby.intellijplugin' do
  name 'ruby'
  url 'http://plugins.jetbrains.com/files/1293/20132/ruby-7.1.0.20150617.zip'
  type :zip
end

dep 'vagrant.intellijplugin' do
  name 'vagrant'
  url 'http://plugins.jetbrains.com/files/7379/19707/vagrant-141.76.zip'
  type :zip
end

dep 'python.intellijplugin' do
  name 'python'
  url 'http://plugins.jetbrains.com/files/631/20878/python-141.2428.zip'
  type :zip
end

dep 'lombok.intellijplugin' do
  name 'lombok'
  url 'http://plugins.jetbrains.com/files/6317/20465/lombok-plugin-0.9.6-14.jar'
  type :jar
end

dep 'markdown.intellijplugin' do
  name 'idea-markdown'
  url 'http://plugins.jetbrains.com/files/5970/17320/idea-markdown.zip'
  type :zip
end

dep 'scala.intellijplugin' do
  name 'scala'
  url 'http://plugins.jetbrains.com/files/1347/21479/scala-intellij-bin-1.5.3.zip'
  type :zip
end

dep 'clojure.intellijplugin' do
  name 'clojure-plugin'
  url 'http://plugins.jetbrains.com/files/4050/19265/clojure-intellij-bin-0.7.82.zip'
  type :zip
end

dep 'anltr.intellijplugin' do
  name 'intellij-plugin-v4'
  url 'http://plugins.jetbrains.com/files/7358/20507/intellij-plugin-v4.zip'
  type :zip
end

dep 'bash.intellijplugin' do
  name 'BashSupport'
  url 'http://plugins.jetbrains.com/files/4230/18873/BashSupport.jar'
  type :jar
end

dep 'intellij plugins' do
  requires 'ruby.intellijplugin'
  requires 'vagrant.intellijplugin'
  requires 'python.intellijplugin'
  requires 'lombok.intellijplugin'
  requires 'markdown.intellijplugin'
  requires 'bash.intellijplugin'
  requires 'antlr.intellijplugin'
  requires 'scala.intellijplugin'
end

dep 'intellij' do
  requires 'intellij-idea.cask'
  requires 'intellij license.file'
  requires 'intellij disabled plugins.file'
  requires 'intellij plugins'
end
