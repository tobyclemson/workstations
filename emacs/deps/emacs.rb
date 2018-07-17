require 'fileutils'

dep 'aspell.brew'

dep 'prelude' do
  requires 'aspell.brew'

  met? {
    '~/.emacs.d/.git'.p.exist?
  }

  meet {
    shell('curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh')
  }
end

dep 'prelude-personal-installed.repo' do
  requires 'git config'

  source 'git@github.com:tobyclemson/prelude-personal'
  path '~/.prelude-personal'
end

dep 'old-prelude-modules-cleanup' do
  met? { '~/.emacs.d/prelude-modules.el'.p.symlink? }
  meet { FileUtils.rm_f('~/.emacs.d/prelude-modules.el'.p.expand_path) }
end

dep 'prelude-modules.link' do
  requires 'prelude'
  requires 'prelude-personal.repo'
  requires 'old-prelude-modules-cleanup'

  source '~/.emacs.d/prelude-modules.el'
  target '~/.prelude-personal/prelude-modules.el'
end

dep 'prelude-personal-init.link' do
  requires 'prelude'
  requires 'prelude-personal.repo'

  source '~/.emacs.d/personal/init.el'
  target '~/.prelude-personal/personal/init.el'
end

dep 'prelude-personal-custom.link' do
  requires 'prelude'
  requires 'prelude-personal.repo'

  source '~/.emacs.d/personal/custom.el'
  target '~/.prelude-personal/personal/custom.el'
end

dep 'prelude-personal-modules.link' do
  requires 'prelude'
  requires 'prelude-personal.repo'

  source '~/.emacs.d/personal/modules'
  target '~/.prelude-personal/personal/modules'
end

dep 'prelude-personal-snippets.link' do
  requires 'prelude'
  requires 'prelude-personal.repo'

  source '~/.emacs.d/personal/snippets'
  target '~/.prelude-personal/personal/snippets'
end

dep 'prelude-personal-themes.link' do
  requires 'prelude'
  requires 'prelude-personal.repo'

  source '~/.emacs.d/personal/themes'
  target '~/.prelude-personal/personal/themes'
end

dep 'prelude-personal-todochiku-icons.link' do
  requires 'prelude'
  requires 'prelude-personal.repo'

  source '~/.emacs.d/personal/todochiku-icons'
  target '~/.prelude-personal/personal/todochiku-icons'
end

dep 'prelude-personal-links' do
  requires 'prelude-modules.link'
  requires 'prelude-personal-init.link'
  requires 'prelude-personal-custom.link'
  requires 'prelude-personal-modules.link'
  requires 'prelude-personal-snippets.link'
  requires 'prelude-personal-themes.link'
  requires 'prelude-personal-todochiku-icons.link'
end

dep 'emacs' do
  requires 'emacs.cask'
  requires 'prelude'
  requires 'prelude-personal-installed.repo'
  requires 'prelude-personal-links'
end
