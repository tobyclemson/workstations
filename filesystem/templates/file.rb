meta "file" do
  accepts_value_for :source
  accepts_value_for :name, :basename
  accepts_value_for :target

  template {

    met? { target.p.exist? }

    meet {
      Babushka::Resource.extract(source) { |archive|
        Dir.glob("**/*#{name}").select {|file|
          log_shell "Copying #{file} to #{target}", "cp -R #{file} #{target}"
        }
      }
    }
  }
end
