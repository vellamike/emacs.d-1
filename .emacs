;;; package --- .emacs - root file of all configs


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This block holds temporary not used funtions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq inferior-lisp-program "/usr/bin/sbcl") ; your Common Lisp impl
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/slime/")  ; your SLIME from CVS
;; (require 'slime)
;; (slime-setup '(slime-fancy))
;;pianobar setting
;(setq pianobar-username "droidlove@ya.ru")
;(setq pianobar-password "password")
;(setq pianobar-station "1")
;(set-face-foreground 'pianobar-mode-info-face "dark green")

;;load emacs in server mode. client can open buffer in the same frame
(load "server")
(unless (server-running-p) (server-start))

(load-file "~/.emacs.d/apperance.el")
(load-file "~/.emacs.d/shortcuts.el")
(load-file "~/.emacs.d/jabber-mode.el")
(load-file "~/.emacs.d/customfunc.el")
(load-file "~/.emacs.d/shell.el")
(load-file "~/.emacs.d/tex.el")
(load-file "~/.emacs.d/scratch.el")
(load-file "~/.emacs.d/python-mode.el")
(load-file "~/.emacs.d/erc-mode.el")
(load-file "~/.emacs.d/org-mode.el")
(load-file "~/.emacs.d/cdlatex.el")


;;Save mode-line history between sessions. Very good!
(setq savehist-additional-variables    ;; Also save ...
  '(search-ring regexp-search-ring)    ;; ... searches
  savehist-file "~/.emacs.d/savehist") ;; keep home clean
(savehist-mode t)

;;;backups
(setq backup-directory-alist `((".*" . "~/.backups_emacs")))
(setq backup-by-copying t)
(setq delete-old-versions t
        kept-new-versions 3
          kept-old-versions 5
            version-control t)

(setq package-archives '(
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ))

;;minibuffer compeltion/suggestions
(icomplete-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                  usefull hooks            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;;Remove/kill completion buffer when done-----
;;could use ido-find-file instead, since it never uses *Completions*
;;Note that ido-mode affects both buffer switch, &  find file.
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))
))

;; make sctipt executable after save
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;;;; usefull hooks ends here ;;;;;;;;;;;;;;;;;;;



;;edit file with as root
(require 'tramp)
(setq tramp-default-method "scp")


(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(setq x-select-enable-clipboard-manager t)
(setq interprogram-paste-function 'x-selection-value)

(setq redisplay-dont-pause t)
(defalias 'yes-or-no-p 'y-or-n-p)
(column-number-mode 1)
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(auto-fill-mode t)
(setq fill-column 80)
(setq standard-indent 2)
(setq inhibit-startup-screen t)
(setq font-lock-maximum-decoration t)

(require 'un-define "un-define" t)
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;;;electric modes
(electric-layout-mode 1)
(electric-pair-mode 1)
(electric-indent-mode 1)

;;;global settings
(setq transient-mark-mode t)
(setq delete-selection-mode t)
;;(global-hl-line-mode t)
(global-visual-line-mode 1)
(desktop-save-mode 1)

;;custom added packages

;google-translate interface
;(require 'google-translate)
(setq googel-translate-default-target-language "ru")
(global-set-key "\C-cT" 'google-translate-at-point)
(global-set-key "\C-ct" 'google-translate-query-translate)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Org" ;; all org-related buffers
                (mode . org-mode))
               ("Programming" ;; prog stuff not already in MyProjectX
                (or
                 (mode . c-mode)
                 (mode . c++-mode)
                 (mode . perl-mode)
                 (mode . python-mode)
                 (mode . emacs-lisp-mode)))
               ("LaTeX"
                (mode . latex-mode))
               ("Directories"
                (mode . dired-mode))
               ))))

(provide '.emacs)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes (quote ("6b1b3ef12a4a429f9d2eae2019115b0a7583563e17525f0a4e9696433f2f3c16" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "PragmataPro" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))
