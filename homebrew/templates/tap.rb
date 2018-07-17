require_relative '../helpers/cask_helper'

meta :tap do
  accepts_value_for :tap

  template {
    requires Babushka::BrewHelper.manager_dep

    def taps
      shell!('brew tap').strip.lines.map(&:strip)
    end

    met? {
      taps.include? tap.to_s
    }

    meet {
      log_block "Tapping Homebrew tap '#{tap}'" do
        shell! 'brew', 'tap', tap.to_s
      end
    }
  }
end