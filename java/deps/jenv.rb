dep 'java-1.8.javaversion' do
  version '1.8'
end

dep 'java-10.javaversion' do
  version '10'
end

dep 'java' do
  requires 'java.cask'
  requires 'java8.cask'
  requires 'jenv.brew'
  requires 'java-1.8.javaversion'
  requires 'java-10.javaversion'
end
