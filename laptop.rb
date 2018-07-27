parse = ->(line) {
  name, parameters = line.strip.split(',')
  name = eval(name)
  parameters = parameters ? eval("{#{parameters}}") : {}

  {name: name, parameters: parameters}
}

homebrew_dep_of_type = ->(type) {
  ->(definition) {
    name = definition[:name]
    parameters = definition[:parameters]

    dep "#{name}.#{type}" do
      requires parameters[:requires] if parameters[:requires]
      opts parameters[:options] if parameters[:options]
    end
  }
}

brew_dep = homebrew_dep_of_type.('brew')
cask_dep = homebrew_dep_of_type.('cask')
tap_dep = ->(definition) {
  name = definition[:name]
  parameters = definition[:parameters]

  dep "#{name}.tap" do
    tap parameters[:tap]
  end
}

taps = File.readlines(File.expand_path '../taps.lst', __FILE__).map(&parse)
brews = File.readlines(File.expand_path '../brews.lst', __FILE__).map(&parse)
casks = File.readlines(File.expand_path '../casks.lst', __FILE__).map(&parse)

taps.each(&tap_dep)
brews.each(&brew_dep)
casks.each(&cask_dep)

dep 'laptop' do
  taps.each {|definition| requires "#{definition[:name]}.tap"}
  brews.each {|definition| requires "#{definition[:name]}.brew"}
  casks.each {|definition| requires "#{definition[:name]}.cask"}

  requires 'git config'

  requires 'all settings'
  requires 'all fonts'
  requires 'all projects'
  requires 'quicklook plugins'

  requires '1password'
  requires 'alfred'
  requires 'dropbox'
  requires 'emacs'
  # requires 'intellij'
  requires 'karabiner-elements'
  requires 'omnigraffle'
  requires 'sizeup'
  requires 'terminal'
  # requires 'vagrant'
  requires 'zsh'
end
