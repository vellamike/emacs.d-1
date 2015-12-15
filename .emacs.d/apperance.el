(load-file "~/.emacs.d/site-lisp/highlight-tail.el")
;(load-file "~/.emacs.d/colors/xemacs-theme.el")
;(load-file "~/.emacs.d/colors/humane-theme.el")
;(load-file "~/.emacs.d/colors/ritchie-theme.el")
(load-file "~/.emacs.d/colors/my_theme.el")

(require 'highlight-tail)
(setq highlight-tail-colors '(("#F7B509" . 0)
                              ("#F7DA17" . 25)
                              ("#FFE746" . 100)))

;; (setq highlight-tail-colors '(("#49467F" . 0)
;;                               ("#323057" . 25)

;;                               ("#1C1B32" . 100)))
(highlight-tail-reload)

(setq font-lock-maximum-decoration t
      color-theme-is-global t)


;maximize emacs
(modify-all-frames-parameters '((fullscreen . maximized)))

;get rid of clutter
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; make fringe smaller
(if (fboundp 'fringe-mode)
    (fringe-mode 8))

;;initial frames Setup
;;set the left window size to 80 and activate the right
(split-window-horizontally 80)
(windmove-right)

(winner-mode 1)

(provide 'apperance.el)
;;; apperance.el ends here
