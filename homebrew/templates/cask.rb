require_relative '../helpers/cask_helper'

meta :cask do
  accepts_value_for :installs, :basename
  accepts_value_for :opts

  template {
    requires Babushka::CaskHelper.manager_dep

    met? {
      Babushka::CaskHelper.has?(installs)
    }

    meet {
      Babushka::CaskHelper.handle_install! installs, opts
    }
  }
end
