;; tdc-ui.el --- UI package.
;;

;;; Commentary:

;; Add UI extensions.

;;; Code:

;; Prefer vertical split
(setq split-height-threshold nil)
(setq split-width-threshold 160)

;; Toggle window dedication
(defun toggle-window-dedication ()
  "Toggle whether the current active window is dedicated or not."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
       "Window '%s' is normal")
   (current-buffer)))
(global-set-key (kbd "C-c j") 'toggle-window-dedication)

;; Custom key bindings
(define-key key-translation-map (kbd "s-3") (kbd "#"))

(provide 'tdc-ui)
