meta "file" do
  accepts_value_for :source
  accepts_value_for :content
  accepts_value_for :target

  def resolved_content
    content || shell("cat #{source.p.cleanpath}")
  end

  template {
    met? {
      target.p.exist? &&
        shell("md5 -q #{target}") == shell("md5", input: resolved_content)
    }

    meet {
      shell("cat > #{target}", input: resolved_content)
    }
  }
end
