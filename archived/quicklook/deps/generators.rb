dep 'qlcolorcode.cask', :for => :osx
dep 'qlstephen.cask', :for => :osx
dep 'quicklook-json.cask', :for => :osx
dep 'quicklook-csv.cask', :for => :osx
dep 'qlimagesize.cask', :for => :osx
dep 'suspicious-package.cask', :for => :osx

dep 'quicklook plugins' do
  requires 'qlcolorcode.cask'
  requires 'qlstephen.cask'
  requires 'quicklook-json.cask'
  requires 'quicklook-csv.cask'
  requires 'qlimagesize.cask'
  requires 'suspicious-package.cask'

  after {
    log_shell "Resetting Quicklook server", "qlmanage -r"
  }
end
