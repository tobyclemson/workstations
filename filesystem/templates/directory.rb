meta :directory do
  accepts_value_for :path

  template {
    met? {
      path.p.exist?
    }

    meet {
      shell("mkdir -p \"#{path.p}\"")
    }
  }
end
