dep 'phpbrew' do
  requires 'curl.brew'

  met? {
    "/usr/local/bin/phpbrew".p.exists?
  }

  meet {
    shell("sudo curl -L " +
              '"https://github.com/phpbrew/phpbrew/raw/master/phpbrew" ' +
              "-o /usr/local/bin/phpbrew")
    shell("sudo chmod +x /usr/local/bin/phpbrew")
    shell("phpbrew init")
    shell("phpbrew lookup-prefix homebrew")
  }
end
