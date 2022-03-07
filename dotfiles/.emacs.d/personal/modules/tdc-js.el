;; tdc-js.el --- JS configuration package.
;;

;;; Commentary:

;; Require JS3 mode, set up snippets and enable line numbers

;;; Code:


(prelude-ensure-module-deps '(js3-mode))
(require 'tdc-snippets)
(require 'tdc-packages)

(add-hook
 'js3-mode-hook
 #'(lambda ()
     (yas-activate-extra-mode 'js-mode)
     (linum-mode))

 (provide 'tdc-js))
