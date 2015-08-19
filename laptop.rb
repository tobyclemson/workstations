parse = ->(line) {
  name, provide_name = line.strip.split(':')
  [name, ->(type) { dep "#{name}.#{type}" do provides provide_name if provide_name end }]
}

brews = File.readlines(File.expand_path '../brews.lst', __FILE__).map(&parse)
casks = File.readlines(File.expand_path '../casks.lst', __FILE__).map(&parse)

brews.each { |name, dep_of_type| dep_of_type['managed'] }
casks.each { |name, dep_of_type| dep_of_type['cask'] }

dep 'laptop' do
  brews.each { |name, _| requires "#{name}.managed" }
  casks.each { |name, _| requires "#{name}.cask" }
end
