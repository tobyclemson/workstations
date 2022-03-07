;; tdc-packages.el --- Personal packages.

;;; Commentary:

;; Set up all packages along with their key bindings

;;; Code:

(prelude-ensure-module-deps '(multiple-cursors imenu-anywhere linum-relative))
(require 'multiple-cursors)
(require 'linum-relative)
(require 'imenu-anywhere)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-=") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "C-.") 'helm-imenu-anywhere)

(global-set-key (kbd "C-c C-l") 'linum-relative-toggle)

(setq linum-relative-current-symbol "")

(setq ispell-dictionary "british")

(provide 'tdc-packages)
