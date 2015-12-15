;;; package --- .emacs - root file of all configs


;;; Commentary:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This block holds temporary not used functions
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
;;; Code:
(require 'server)
(unless (server-running-p) (server-start))

(load-file "~/.emacs.d/apperance.el")
(load-file "~/.emacs.d/shortcuts.el")
(load-file "~/.emacs.d/jabber-mode.el")
(load-file "~/.emacs.d/customfunc.el")
(load-file "~/.emacs.d/shell.el")
(load-file "~/.emacs.d/tex.el")
(load-file "~/.emacs.d/scratch.el")
;(load-file "~/.emacs.d/python-mode.el")
(load-file "~/.emacs.d/erc-mode.el")
(load-file "~/.emacs.d/ibuffer.el")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
;(load-file "~/.emacs.d/site-lisp/auto-complete-clang-async.el")
(load-file "~/.emacs.d/site-lisp/dna-mode.el")
(load-file "~/.emacs.d/site-lisp/bioseq-mode.el")
(load-file "~/.emacs.d/site-lisp/smart-operator.el")
(load-file "~/.emacs.d/bio-mode.el")
(load-file "~/.emacs.d/org-mode.el")


;;
;Save mode-line history between sessions. Very good!
(setq savehist-additional-variables    ;; Also save ...
      '(search-ring regexp-search-ring)    ;; ... searches
      savehist-file "~/.savehist_emacs")
(savehist-mode t)

;;;backups
(setq backup-directory-alist `((".*" . "~/.backups_emacs")))
(setq backup-by-copying t)
(setq delete-old-versions t
        kept-new-versions 30
          kept-old-versions 50
            version-control t)

(setq  package-archives '(
                         ("melpa" . "http://melpa.org/packages/")
                         ("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ))

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
(require 'ido)
(ido-mode t)

;; make sctipt executable after save
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;;;; usefull hooks ends here ;;;;;;;;;;;;;;;;;;;

(require 'ispell)
(setq ispell-dictionary "deutsch8")
(setq ispell-local-dictionary "deutsch8")
(setq ispell-default-dictionary "deutsch8")
(setq flyspell-default-dictionary "deutsch8")

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
(show-paren-mode 1)
(setq font-lock-maximum-decoration t)
(setq require-final-newline t)

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
(global-hl-line-mode t) ;; hl-anything package
;;(global-visual-line-mode 1)
(desktop-save-mode 1)


;;custom added packages
(require 'package)
(package-initialize)


;(global-rainbow-delimiters-mode t)

;auto-complete-mode
(when (display-graphic-p)
  (ac-config-default)
  (global-auto-complete-mode t)

  (defun ielm-auto-complete ()
  "Enables `auto-complete' support in \\[ielm]."
  (setq ac-sources '(ac-source-functions
                     ac-source-variables
                     ac-source-features
                     ac-source-symbols
                     ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'inferior-emacs-lisp-mode)
  (auto-complete-mode 1))

  (add-hook 'ielm-mode-hook 'ielm-auto-complete))
; hack to fix ac-sources after pycomplete.el breaks it
(add-hook 'python-mode-hook
'(lambda ()
(setq ac-sources '(ac-source-pycomplete
ac-source-yasnippet
ac-source-abbrev
ac-source-dictionary
ac-source-words-in-same-mode-buffers))))
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")
(setq ac-auto-start 2)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward uniquify-separator ":")


;google-translate interface
;(require 'google-translate)
(defvar google-translate-default-source-language "en")
(defvar google-translate-default-target-language "ru")


(delete-selection-mode t)
(setq show-paren-style 'expression)
(setq display-time-24hr-format t)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
)

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(my-ac-config)

(setq auto-mode-alist (rassq-delete-all 'perl-mode auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.\\(p\\([lm]\\)\\)\\'" . cperl-mode))

;; higlight changes in documents
(global-highlight-changes-mode t)
(setq highlight-changes-visibility-initial-state nil); initially hide

;ivy completion mode
(ivy-mode 1)
(setq ivy-display-style 'fancy)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key "\C-r" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
;;advise swiper to recenter on exit
(defun bjm-swiper-recenter (&rest args)
  "recenter display after swiper"
  (recenter)
  )
(advice-add 'swiper :after #'bjm-swiper-recenter)

(provide '.emacs)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d9db2602073498bfa3d591e2ce70de3e9c144c30aeacf9e667b0fb9139f38f50" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
