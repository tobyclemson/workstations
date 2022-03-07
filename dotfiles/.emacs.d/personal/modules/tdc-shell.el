;; tdc-shell.el --- Shell package.
;;

;;; Commentary:

;; Use zsh.

;;; Code:

;; use zsh instead of bash
(setq explicit-shell-file-name "zsh")
(setenv "SHELL" explicit-shell-file-name)

(provide 'tdc-shell)
