dep 'homebrew tap', :tap_name, :for => :osx do
  requires 'homebrew'

  def taps
    shell!('brew tap').strip.lines.map(&:strip)
  end

  met? { taps.include? tap_name.to_s }
  meet {
    log_block "Tapping Homebrew tap '#{tap_name}'" do
      shell! 'brew', 'tap', tap_name.to_s
    end
  }
end
