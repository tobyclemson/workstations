dep 'git user details' do
  requires 'email.gitconfig'
  requires 'name.gitconfig'
end

dep 'email.gitconfig' do
  key 'user.email'
  value 'tobyclemson@gmail.com'
end

dep 'name.gitconfig' do
  key 'user.name'
  value 'Toby Clemson'
end

dep 'github ssh access', :github_username, :github_pat, :github_otp do
  requires 'ssh key'

  def github_api
    'https://api.github.com'
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
    github_username.ask('What is your github username')
    github_pat.ask('What is your github personal access token')
    github_otp.ask('What is your github OTP code')

    args = "{\"title\": \"#{hostname}\", \"key\": \"#{public_key}\"}"

    shell("curl -X POST " +
        "-u '#{github_username}:#{github_pat}' " +
        "-H 'content-type: application/json' " +
        "-H 'x-github-otp: #{github_otp}' " +
        "-d '#{args}' #{github_api}/user/keys")
  }
end

dep 'git config' do
  requires 'git.brew'
  requires 'git user details'
  requires 'github ssh access'
end
