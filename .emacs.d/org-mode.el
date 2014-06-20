;;; org-mode
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)
(setq org-startup-indented nil)
(setq org-startup-folded nil)
(setq org-src-fontify-natively t)
(setq org-agenda-files '("~/Dropbox/org/"))
(setq org-directory "~/Dropbox/org/")
(setq org-mobile-directory "~/Dropbox/org/")
(setq org-mobile-inbox-for-pull "~/Dropbox/org/")
;;enable encryption
;(setq org-mobile-use-encryption t)
;;set pass
;(setq org-mobile-encryption-password "&&&&&&&&")
;;transparent encrypt
;(require 'epa-file)
;(epa-file-enable)
;(setq epa-armor t)
;(setq org-mobile-inbox-for-pull "~/notes/org/inbox.org")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . true))
 )

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/todo.org") "Tasks")
         "* TODO %?\n %i\n")
        ("f" "Link" plain (file (concat org-directory "/fav.org"))
         "- %?\n %x\n")
         ("r" "add book to read" checkitem (file (concat org-directory "/want_read.org"))
          "[ ] %?\n %i\n")
         ))
