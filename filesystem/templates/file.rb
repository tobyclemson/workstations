meta "file" do
  accepts_value_for :source
  accepts_value_for :name, :basename
  accepts_value_for :target

  template {
    met? {
      target.p.exist? &&
        shell("md5 #{target}") == shell("md5 #{source}")
    }

    meet {
      shell("cp -R #{source} #{target}")
    }
  }
end
