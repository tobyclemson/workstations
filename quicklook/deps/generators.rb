dep 'qlcolorcode.cask', :for => :osx
dep 'qlstephen.cask', :for => :osx
dep 'qlmarkdown.cask', :for => :osx
dep 'quicklook-json.cask', :for => :osx
dep 'quicklook-csv.cask', :for => :osx
dep 'betterzipql.cask', :for => :osx
dep 'qlimagesize.cask', :for => :osx
dep 'suspicious-package.cask', :for => :osx

dep 'quicklook plugins' do
  requires 'qlcolorcode.cask'
  requires 'qlstephen.cask'
  requires 'qlmarkdown.cask'
  requires 'quicklook-json.cask'
  requires 'quicklook-csv.cask'
  requires 'betterzipql.cask'
  requires 'qlimagesize.cask'
  requires 'suspicious-package.cask'
end
