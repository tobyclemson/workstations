dep 'phpbrew' do
  requires 'curl.brew'

  def current_user
    shell('whoami')
  end

  met? {
    "/usr/local/bin/phpbrew".p.exists?
  }

  meet {
    shell("sudo curl -L " +
              '"https://github.com/phpbrew/phpbrew/raw/master/phpbrew" ' +
              "-o /usr/local/bin/phpbrew")
    shell("sudo chmod +x /usr/local/bin/phpbrew")
    shell("sudo chown #{current_user}:wheel /usr/local/bin/phpbrew")
    shell("phpbrew init")
    shell("source ~/.phpbrew/bashrc && phpbrew lookup-prefix homebrew")
  }
end
