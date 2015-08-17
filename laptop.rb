parse = ->(line) {
  name, provide_name = line.strip.split(':')
  [name, ->(type) { dep "#{name}.#{type}" do provides provide_name if provide end }]
}

brews = File.readlines(File.expand_path '../brews.lst', __FILE__).map(&parse)

brews.each { |name, dep_of_type| dep_of_type['managed'] }

dep 'laptop' do
  brews.each { |name, _| requires "#{name}.managed" }
end
