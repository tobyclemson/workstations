dep 'jenv-versions.directory' do
  path '~/.jenv/versions'
end

dep 'java-8.javaversion' do
  version '8'
end

dep 'java-10.javaversion' do
  version '10'
end

dep 'java' do
  requires 'java.cask'
  requires 'adoptopenjdk8.cask'
  requires 'jenv.brew'
  requires 'jenv-versions.directory'
  requires 'java-8.javaversion'
  requires 'java-10.javaversion'
end
