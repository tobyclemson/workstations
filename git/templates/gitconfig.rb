meta :gitconfig do
  accepts_value_for :key
  accepts_value_for :value

  template {
    requires 'git.managed'

    met? {
      `git config --global --get "#{key}"`.chomp == value
    }
    meet {
      shell "git config --global '#{key}' '#{value}'"
    }
  }
end
