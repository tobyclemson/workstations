meta :shell do
  template {
    met? { '/etc/shells'.p.grep(which(basename)) }
    meet { shell("echo \"#{which(basename)}\" >> /etc/shells", :sudo => true) }
  }
end
