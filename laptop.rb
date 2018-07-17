parse = ->(line) {
  name, options = line.strip.split(',')
  name = eval(name)
  options = options ? eval("{#{options}}") : {}

  puts name, options

  [name, options]
}

homebrew_dep_of_type = ->(type) {
  ->(name, options) {
    dep "#{name}.#{type}" do
      requires options[:requires] if options[:requires]
      opts options.delete_if { |key| [:provides, :requires].include?(key) }
    end
  }
}

brew_dep = homebrew_dep_of_type.('brew')
cask_dep = homebrew_dep_of_type.('cask')

# taps = File.readlines(File.expand_path '../taps.lst', __FILE__).map(&parse)
brews = File.readlines(File.expand_path '../brews.lst', __FILE__).map(&parse)
casks = File.readlines(File.expand_path '../casks.lst', __FILE__).map(&parse)

brews.each(&brew_dep)
casks.each(&cask_dep)

dep 'laptop' do
  # taps.each {|tap| requires "homebrew tap".with(tap)}
  brews.each {|name, _| requires "#{name}.brew"}
  casks.each {|name, _| requires "#{name}.cask"}

  # requires 'git config'
  #
  # requires 'all settings'
  # requires 'all fonts'
  # requires 'all projects'
  # requires 'quicklook plugins'
  #
  # requires '1password'
  # requires 'alfred'
  # requires 'dropbox'
  # requires 'emacs'
  # # requires 'intellij'
  # requires 'karabiner'
  # requires 'omnigraffle'
  # requires 'sizeup'
  # requires 'terminal'
  # # requires 'vagrant'
  # requires 'zsh'
end
