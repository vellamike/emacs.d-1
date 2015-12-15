;;;;custom keyboard scuts
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key [f1] 'ibuffer)
(global-set-key [f2] 'avy-goto-char)
(global-set-key [f3] 'highlight-changes-visible-mode)
(global-set-key [f4] 'previous-error)
(global-set-key [f5] 'next-error)
(global-set-key [f6] 'compile)
(global-set-key [f7] 'recompile)
(global-set-key [f8] 'eshell)
(global-set-key [f9] 'flymake-display-err-menu-for-current-line)
(global-set-key [f10] 'flymake-goto-next-error)
;;set bookmarks for fast jumps back to previous position
(global-set-key [f11] 'kill-this-buffer)
(global-set-key [f12] 'bookmark-jump)

(global-set-key (kbd "C-:") 'avy-goto-char)

;swiper mode
(global-set-key "\C-s" 'swiper)
(global-set-key "\C-r" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)

;;travel across windows with meta--><-
(windmove-default-keybindings 'meta)

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
(global-set-key "\C-cT" 'google-translate-at-point)
(global-set-key "\C-ct" 'google-translate-query-translate)


;;same in color theme
;(highlight-changes ((t (:foreground nil :background "#382f2f"))))
;(highlight-changes-delete ((t (:foreground nil :background "#916868"))))

 ;; optional keyboard short-cut
(global-set-key "\C-xb" 'browse-url-at-point)

;; backward kill region to C-w(already taken shortcut)
(global-set-key "\C-q" 'backward-kill-word)
;(global-set-key "\C-x\C-k" 'kill-region)
;;jump to a definition in the current file
(global-set-key (kbd "C-x C-i") 'imenu)
;; Help should search more than just commands
(define-key 'help-command "a" 'apropos)

(global-set-key [mouse-8] '(lambda ()
                             (interactive)
                             (scroll-down 1)))
(global-set-key [mouse-9] '(lambda ()
                             (interactive)
                             (scroll-up 1)))

(global-set-key (kbd "M-j") '(lambda ()
                             (interactive)
                             (join-line  -1)))

;;;duplicate line instead of ca ck ck cy cy
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank)
)
(global-set-key (kbd "C-d") 'duplicate-line)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cr" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;;semantic keymaps
;(defun my-cedet-hook ()
;  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
;(add-hook 'c-mode-common-hook 'my-cedet-hook)

(global-set-key [remap goto-line] 'goto-line-with-feedback)

(global-set-key "\C-cp" 'google-translate-at-point)
(global-set-key "\C-ct" 'google-translate-query-translate)

;;Awesome copy/paste!----------------------
;;My most used hack! If nothing is marked/highlighted, and you copy or cut
;;(C-w or M-w) then use column 1 to end. No need to "C-a C-k" or "C-a C-w" etc.
(defadvice kill-ring-save (before slick-copy activate compile) "When called
  interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "1 line killed")
      (list (line-beginning-position)
        (line-beginning-position 2)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; toggle between most recent buffers                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun switch-to-previous-buffer ()
  "Switch to most recent buffer. Repeated calls toggle back and forth between the most recent two buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; set key binding
(global-set-key (kbd "C-`") 'switch-to-previous-buffer)
