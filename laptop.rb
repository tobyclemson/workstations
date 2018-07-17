parse = ->(line) {
  name, parameters = line.strip.split(',')
  name = eval(name)
  parameters = parameters ? eval("{#{parameters}}") : {}

  require 'pp'
  pp [name, parameters]

  {name: name, parameters: parameters}
}

homebrew_dep_of_type = ->(type) {
  ->(definition) {
    name = definition[:name]
    parameters = definition[:parameters]

    require 'pp'
    pp ["#{name}.#{type}", parameters]

    dep "#{name}.#{type}" do
      requires parameters[:requires] if parameters[:requires]
      opts parameters[:options] if parameters[:options]
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
  brews.each {|definition| requires "#{definition[:name]}.brew"}
  casks.each {|definition| requires "#{definition[:name]}.cask"}

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
