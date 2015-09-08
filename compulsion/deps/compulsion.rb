dep 'easysimbl.cask', :for => :osx

dep 'user simbl directory', :for => :osx do
  user_simbl_plugins_directory = '~/Library/Application Support/SIMBL/Plugins'
  
  met? { '~/Library/Application Support/SIMBL/Plugins'.p.dir? }
  meet { log_shell "Creating #{user_simbl_plugins_directory}", "mkdir -p ~/Library/Application\\ Support/SIMBL/Plugins" }
end

dep 'compulsion', :for => :osx do
  requires 'easysimbl.cask',
           'user simbl directory'

  met? {
    "~/Library/Application Support/SIMBL/Plugins/Compulsion.bundle".p.dir?
  }

  meet {
    log_shell "Installing Compulsion.bundle",
              "cp -R #{__FILE__.p.parent}/../files/Compulsion.bundle ~/Library/Application\\ Support/SIMBL/Plugins/"
  }
end