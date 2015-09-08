meta :plist do
  accepts_value_for :target

  template {
    setup {
      requires 'plist exists'.with(target: target)
    }
  }
end

dep 'plist exists', :target do
  met? {
    target.p.exist?
  }

  meet {
    shell("mkdir -p $(dirname \"#{target}\")")
    shell("cp #{__FILE__.p.parent}/../files/empty.plist `cd \"#{target}\"; pwd`")
  }
end
