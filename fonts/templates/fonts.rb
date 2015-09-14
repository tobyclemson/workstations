meta "ttf" do
  accepts_list_for :source
  accepts_list_for :ttf_filename

  template {
    requires "user font dir exists"
    met? {
      "~/Library/Fonts/#{ttf_filename.first}".p.exists?
    }
    meet {
      source.each do |uri|
        Babushka::Resource.extract(uri) do
          Dir.glob("*.ttf") do |font|
            log_shell "Installing #{font}", "cp #{font} ~/Library/Fonts"
          end
        end
      end
    }
  }
end

meta "otf" do
  accepts_list_for :source
  accepts_list_for :otf_filename

  template {
    requires "user font dir exists"
    met? {
      "~/Library/Fonts/#{otf_filename.first}".p.exists?
    }
    meet {
      source.each do |uri|
        Babushka::Resource.extract(uri) do
          Dir.glob("**/*.otf") do |font|
            log_shell "Installing #{font}", "cp #{font} ~/Library/Fonts"
          end
        end
      end
    }
  }
end
