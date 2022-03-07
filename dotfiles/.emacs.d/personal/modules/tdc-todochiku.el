;; tdc-todochiku.el --- Notifications package.
;;

;;; Commentary:

;; Configure notifications.

;;; Code:


(prelude-ensure-module-deps '(todochiku))
(require 'todochiku)

(defvar tdc-todochiku-icons-dir
  (expand-file-name "todochiku-icons" prelude-personal-dir)
  "The directory containing todochiku icons.")

(setq todochiku-icons-directory tdc-todochiku-icons-dir)

(provide 'tdc-todochiku)
