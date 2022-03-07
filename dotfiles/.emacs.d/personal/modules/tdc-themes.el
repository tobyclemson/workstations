;; tdc-themes.el --- Themes package.
;;

;;; Commentary:

;; Add custom themes directory and use blackboard by default.

;;; Code:


;; Set default theme
(defvar tdc-themes-dir (expand-file-name "themes" prelude-personal-dir)
  "The directory containing personal themes.")

(add-to-list 'custom-theme-load-path tdc-themes-dir)

(disable-theme 'zenburn)
(load-theme 'blackboard t)

(provide 'tdc-themes)
