dep 'github personal access token', :github_personal_access_token do
  credentials_file = '~/.github/personal_access_token'

  met? {
    credentials_file.p.exist?
  }

  meet {
    github_personal_access_token
        .ask('What is your github personal access token')

    shell("mkdir -p \"#{credentials_file.p.dirname}\"")
    shell("cat > '#{credentials_file.p.cleanpath}'",
        input: github_personal_access_token)
  }
end

dep 'github ssh access' do
  requires 'ssh key'
  requires 'github personal access token'

  def github_api
    'https://api.github.com'
  end

  def github_personal_access_token
    shell('cat ~/.github/personal_access_token')
  end

  def public_key
    shell('cat ~/.ssh/id_rsa.pub')
  end

  def hostname
    shell('hostname')
  end

  met? {
    raw_shell('ssh -T git@github.com 2>&1').stdout['successfully authenticated']
  }

  meet {
    args = "{\"title\": \"#{hostname}\", \"key\": \"#{public_key}\"}"

    shell("curl -X POST " +
        "-H 'authorization: token #{github_personal_access_token}' " +
        "-H 'content-type: application/json' " +
        "-d '#{args}' #{github_api}/user/keys")
  }
end

dep 'github config' do
  requires 'github ssh access'
end
