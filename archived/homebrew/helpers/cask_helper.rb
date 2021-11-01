class CaskHelper < Babushka::BrewHelper
  class << self
    def pkg_binary; 'brew' end
    def pkg_cmd; 'brew cask' end
    def manager_dep; 'homebrew' end
    def pkg_type; :cask end
    def manager_key; :cask end

    # Delegate prefix to Homebrew helper
    def prefix
      Babushka::BrewHelper.prefix
    end

    def should_sudo?
      false
    end

    def all_versions_of pkg
      pkg_name = pkg.respond_to?(:name) ? pkg.name : pkg
      Dir[
        installed_pkgs_path / pkg_name / '*'
      ].map {|i|
        File.basename i.chomp('/')
      }.map(&:to_s)
    end

    # The place where Homebrew casks are installed.
    #
    # Currently this uses the default caskroom for Homebrew, which
    # is "/usr/local/Caskroom".
    #
    # TODO: make this determine the real caskroom
    def caskroom
      "/usr/local/Caskroom".p
    end

    private
      # Don't check versions
      def has_pkg? pkg
        all_versions_of(pkg).any?
      end

      # The default implementation is "brew cask update", but Homebrew
      # Cask doesn't have its own explicit "update" operation, it just
      # uses Homebrew's standard update.
      def pkg_update_command
        "brew update"
      end

      # Homebrew Cask can't install a particular version on the CLI,
      # so we need to remove the --version flag from the default
      # implementation.
      def cmdline_spec_for pkg
        pkg.name
      end

      def has_formula_for? pkg
        existing_formulas.include? pkg.name
      end

      # Include multiple formulas paths (from taps)
      def existing_formulas
        formulas_paths.map {|path|
          Dir[path / '*.rb'].map {|i| File.basename i, '.rb' }
        }.flatten.uniq
      end

      # Homebrew Cask packages get installed in the "caskroom"
      def installed_pkgs_path
        caskroom
      end

      # The path where Cask formulae are kept
      #
      # e.g.: "/usr/local/Cellar/brew-cask/0.25.0/Casks"
      def formulas_paths
        [
          Dir[taps_path / '**' / 'Casks'].map(&:p),
        ].flatten
      end
  end
end

Babushka::PkgHelper.all_manager_keys << CaskHelper.manager_key
