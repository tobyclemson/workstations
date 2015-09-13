meta "link" do
  accepts_value_for :source
  accepts_value_for :target

  template {
    met? {
      shell?("[ \"$(readlink \"#{source.p.cleanpath}\")\" = \"#{target.p.cleanpath}\" ]")
    }

    meet {
      shell("ln -s \"#{target.p.cleanpath}\" \"#{source.p.cleanpath}\"")
    }
  }
end
