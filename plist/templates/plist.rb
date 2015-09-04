meta :plist do
  accepts_value_for :target

  template {
    requires 'plist exists'.with(target: target)
    
    met? {
      
    }

    meet {
      
    }
  }
end

dep 'plist exists', :target do
  met? {
    target.p.exist?
  }

  meet {
    shell("cp #{__FILE__.p.parent}/../files/empty.plist `cd \"#{target}\"; pwd`")
  }
end
