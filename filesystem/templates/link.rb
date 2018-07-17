meta :link do
  accepts_value_for :source
  accepts_value_for :target
  accepts_value_for :use_sudo

  template {
    met? {
      shell?("[ \"$(readlink \"#{source.p.cleanpath}\")\" = \"#{target.p.cleanpath}\" ]")
    }

    meet {
      shell("ln -s \"#{target.p.cleanpath}\" \"#{source.p.cleanpath}\"", :sudo => use_sudo)
    }
  }
end
