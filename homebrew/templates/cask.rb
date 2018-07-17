require_relative '../helpers/cask_helper'

meta :cask do
  accepts_value_for :installs, :basename
  accepts_value_for :opts

  template {
    requires CaskHelper.manager_dep

    met? {
      CaskHelper.has?(installs)
    }

    meet {
      CaskHelper.handle_install!(installs, opts)
    }
  }
end
