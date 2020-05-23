dep 'sdkman' do
  requires 'curl.brew'

  met? {
    File.expand_path("~/.sdkman/bin/sdkman-init.sh").p.exists?
  }

  meet {
    shell("curl -s \"https://get.sdkman.io\" | bash")
  }
end