dep 'easysimbl.cask', :for => :osx

dep 'user simbl directory', :for => :osx do
  met? { '~/Library/Application Support/SIMBL/Plugins'.p.dir? }
  meet { log_shell "Creating #{user_simbl_plugins_directory}", "mkdir -p $HOME/Library/Application\\ Support/SIMBL/Plugins" }
end

dep 'compulsion', :for => :osx do
  requires 'easysimbl.cask',
           'user simbl directory'

  met? {
    "~/Library/Application Support/SIMBL/Plugins/Compulsion.bundle".p.dir?
  }

  meet {
    log_shell "Installing Compulsion.bundle",
              "cp -R #{__FILE__.p.parent}/../files/Compulsion.bundle $HOME/Library/Application\\ Support/SIMBL/Plugins/"
  }
end
