;; tdc-erc.el --- ERC configuration.
;;

;;; Commentary:

;; Add ERC modules, setup authentication and setup authentication

;;; Code:

(prelude-ensure-module-deps '(erc-hl-nicks erc-image erc-tweet))
(require 'erc-hl-nicks)
(require 'erc-tweet)
(require 'erc-image)
(require 'erc-join)
(require 'tdc-todochiku)

(erc-autojoin-enable)

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#ansible")))

(setq erc-nick "tobyclemson")
(setq erc-auto-query "frame")
(setq erc-image-inline-rescale 'window)

(add-to-list 'auth-source-protocols '(irc "irc" "6667"))

(add-to-list 'erc-modules 'spelling)
(add-to-list 'erc-modules 'keep-place)
(add-to-list 'erc-modules 'log)
(add-to-list 'erc-modules 'tweet)
(add-to-list 'erc-modules 'image)

(delete 'truncate 'erc-modules)

(defface erc-keyword-bad-face '((t (:foreground "IndianRed")))
  "ERC face to highlight keywords indicating something bad happened"
  :group 'erc-faces)

(defface erc-keyword-good-face '((t (:foreground "Green")))
  "ERC face to highlight keywords indicating something good happened"
  :group 'erc-faces)

(defface erc-keyword-warning-face '((t (:foreground "Orange")))
  "ERC face to highlight keywords indicating something that you should be warned about happened"
  :group 'erc-faces)

(defface erc-keyword-still-bad-face '((t (:foreground "Red")))
  "ERC face to highlight keywords indicating something bad is still happening"
  :group 'erc-faces)

(defface erc-keyword-informative-face '((t (:foreground "Yellow")))
  "ERC face to highlight keywords indicating something you might want to know about happened"
  :group 'erc-faces)

(setq erc-keywords '(("SUCCESS" erc-keyword-good-face)
                     ("FIXED" erc-keyword-good-face)
                     ("\\*\\* OK \\*\\*" erc-keyword-good-face)
                     ("STILL FAILING" erc-keyword-still-bad-face)
                     ("\\*\\* WARNING \\*\\*" erc-keyword-warning-face)
                     ("STARTED" erc-keyword-informative-face)
                     ("FINISHED" erc-keyword-informative-face)
                     ("\\*\\* CRITICAL \\*\\*" erc-keyword-bad-face)
                     ("ABORTED" erc-keyword-bad-face)
                     ("FAILED" erc-keyword-bad-face)
                     ("FAILURE" erc-keyword-bad-face)))

(defun connect-to (irc-server-url)
  (erc :server irc-server-url
       :nick "tobyclemson"))

(defun connect-to-freenode-irc ()
  (interactive)
  (connect-to "irc.freenode.net"))

(defun connect-irc ()
  (interactive)
  (connect-to-freenode-irc))

(defun notify-privmsg (proc parsed)
  (let ((nick (car (erc-parse-user (erc-response.sender parsed))))
        (target (car (erc-response.command-args parsed)))
        (msg (erc-response.contents parsed)))
    (when (and (erc-current-nick-p target)
               (not (erc-is-message-ctcp-and-not-action-p msg)))
      (todochiku-message (format "ERC message from: %s" nick)
                         msg
                         (todochiku-icon 'irc)
                         nil))))

(defun notify-nick-mentioned (match-type nick msg)
  (when (eq match-type 'current-nick)
    (todochiku-message (format "%s mentioned your nick." (car (split-string nick "!")))
                       msg
                       (todochiku-icon 'irc)
                       t)))

(add-hook 'erc-text-matched-hook 'notify-nick-mentioned)
(add-hook 'erc-server-PRIVMSG-functions 'notify-privmsg t)
(add-hook 'erc-server-PRIVMSG-functions 'erc-server-PRIVMSG t)
(add-hook 'erc-mode-hook
          '(lambda ()
             (set (make-variable-buffer-local 'case-fold-search) nil)
             (set (make-variable-buffer-local 'image-animate-loop) 't)))

(erc-update-modules)

(provide 'tdc-erc)
