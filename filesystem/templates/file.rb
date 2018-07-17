meta :file do
  accepts_value_for :source
  accepts_value_for :content
  accepts_value_for :target

  def resolved_content
    content || shell("cat #{source.p.cleanpath}")
  end

  template {
    met? {
      target.p.exist? &&
        shell("md5 -q '#{target.p.cleanpath}'") == shell("md5", input: resolved_content)
    }

    meet {
      shell("mkdir -p \"#{target.p.dirname}\"")
      shell("cat > '#{target.p.cleanpath}'", input: resolved_content)
    }
  }
end
