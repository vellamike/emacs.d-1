;;; jabber-mode.el ---

;; Copyright (C) 2013

;; Author:  <xf0e@cassiopeia>

;;; Commentary:

;;

;;; Code:

;;;;;;;;;;;;;;;;;
;; Jabber Mode ;;
;;;;;;;;;;;;;;;;;

(setq  jabber-account-list
    (quote (
            ("0xbadc0de@jabber.ru/emacs" (:password . "") (:connection-type . ssl) )
;            ("hope@jabbim.com/emacs" (:password . "") )
           )
    )
)

;; (setq
;;     jabber-history-enabled t
;;     jabber-use-global-history nil
;;     jabber-backlog-number 40
;;     jabber-backlog-days 30
;; )

;; (add-hook 'jabber-chat-mode-hook 'goto-address)

;; (defvar libnotify-program "/usr/bin/kdialog")

;; (defun notify-send (title message)
;;   (start-process "notify" " notify"x
;;                  libnotify-program "--passivepopup" title "1" "--title" message))

;; (defun libnotify-jabber-notify (from buf text proposed-alert)
;;   "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
;;   (when (or jabber-message-alert-same-buffer
;;                         (not (memq (selected-window) (get-buffer-window-list buf))))
;;     (if (jabber-muc-sender-p from)
;;         (notify-send (format "(PM) %s"
;;                              (jabber-jid-displayname (jabber-jid-user from)))
;;                      (format "%s: %s" (jabber-jid-resource from) text)))
;;     (notify-send (format "%s" (jabber-jid-displayname from))
;;                  text)))

;; (add-hook 'jabber-alert-message-hooks 'libnotify-jabber-notify)

;; (defun jabber-visit-history (jid)
;;   "Visit jabber history with JID in a new buffer.

;; Performs well only for small files. Expect to wait a few seconds
;; for large histories. Adapted from `jabber-chat-create-buffer'."
;;   (interactive (list (jabber-read-jid-completing "JID: ")))
;;   (let ((buffer (generate-new-buffer (format "*-jabber-history-%s-*"
;;                                              (jabber-jid-displayname jid)))))
;;     (switch-to-buffer buffer)
;;     (make-local-variable 'jabber-chat-ewoc)
;;     (setq jabber-chat-ewoc (ewoc-create #'jabber-chat-pp))
;;     (mapc 'jabber-chat-insert-backlog-entry
;;           (nreverse (jabber-history-query nil nil t t "."
;;                                           (jabber-history-filename jid))))
;;     (view-mode)))



(provide 'jabber-mode)
;;; jabber-mode.el ends here
