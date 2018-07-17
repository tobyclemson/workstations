meta :brew do
  accepts_value_for :provides, :basename
  accepts_value_for :installs, :basename
  accepts_value_for :opts

  template {
    requires Babushka::BrewHelper.manager_dep

    met? {
      Babushka::BrewHelper.has?(provides)
    }

    meet {
      Babushka::BrewHelper.handle_install! installs, opts
    }
  }
end
