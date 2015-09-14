meta :shell do
  template {
    met? { '/etc/shells'.p.grep(which(basename)) }
    meet { append_to_file which(basename), '/etc/shells', :sudo => true }
  }
end
