class GpgHelper
  class << self
    include Babushka::ShellHelpers

    def decrypt(path)
      log_shell("Decrypting value from #{path}", "gpg -d #{__FILE__.p.parent.parent.parent}/#{path}")
    end
  end
end
