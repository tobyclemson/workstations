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

dep 'git config' do
  requires 'git.brew'
  requires 'git user details'
end
