;; tdc-rspec.el --- RSpec configuration package.
;;

;;; Commentary:

;; Always use bash for running specs

;;; Code:


(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))
(ad-activate 'rspec-compile)

(provide 'tdc-rspec)
