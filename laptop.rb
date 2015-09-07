parse = ->(line) {
  name, provide_name, require_name = line.strip.split(':')
  
  dep_builder = ->(type) do
    dep "#{name}.#{type}" do
      provides provide_name if provide_name
      requires require_name if require_name
    end
  end
  [name, dep_builder]
}

taps = File.readlines(File.expand_path '../taps.lst', __FILE__).map { |tap| tap.strip }
brews = File.readlines(File.expand_path '../brews.lst', __FILE__).map(&parse)
casks = File.readlines(File.expand_path '../casks.lst', __FILE__).map(&parse)

brews.each { |name, dep_of_type| dep_of_type['managed'] }
casks.each { |name, dep_of_type| dep_of_type['cask'] }

dep 'laptop' do
  taps.each { |tap| requires "homebrew tap".with(tap) }
  brews.each { |name, _| requires "#{name}.managed" }
  casks.each { |name, _| requires "#{name}.cask" }

  requires 'all settings'
  requires 'quicklook plugins'
  requires 'computer name'.with('falkor', 'falkor')

  requires 'compulsion'
  requires 'zsh'
  requires 'alfred'
end
