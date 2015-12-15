;;;;;;;;;;;;;;;;
;; Python IDE ;;
;;;;;;;;;;;;;;;;
;(package-initialize)
;(elpy-enable)

(c-add-style
   "python-new"
   '((indent-tabs-mode . nil)
     (fill-column      . 78)
     (c-basic-offset   . 4)
     (c-offsets-alist  . ((substatement-open . 0)
                          (inextern-lang     . 0)
                          (arglist-intro     . +)
                          (knr-argdecl-intro . +)))
     (c-hanging-braces-alist . ((brace-list-open)
                                (brace-list-intro)
                                (brace-list-close)
                                (brace-entry-open)
                                (substatement-open after)
                                (block-close . c-snug-do-while)))
     (c-block-comment-prefix . "* "))
)

;; This is a very crude hook that auto-selects the C style depending on
;; whether it finds a line starting with tab in the first 3000 characters
;; in the file
(defun c-select-style ()
   (save-excursion
     (if (re-search-forward "^\t" 3000 t)
         (c-set-style "python")
       (c-set-style "python-new"))))
(add-hook 'c-mode-hook 'c-select-style)


; python-mode
(setq py-install-directory "~/.emacs.d/elpa/python-mode-6.1.3")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)


; use IPython
(setq-default py-shell-name "ipython2")
(setq-default py-which-bufname "IPython")
; use the wx backend, for both mayavi and matplotlib
(setq
python-shell-interpreter "ipython"
python-shell-interpreter-args "--gui=wx --matplotlib=wx --colors=Linux"
python-shell-prompt-regexp "In \\[[0-9]+\\]: "
python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
python-shell-completion-setup-code
"from IPython.core.completerlib import module_completion"
python-shell-completion-module-string-code
"';'.join(module_completion('''%s'''))\n"
python-shell-completion-string-code
"';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
(setq py-force-py-shell-name-p t)

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
; don't split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)

(eval-after-load 'python
'(define-key python-mode-map (kbd "C-c !") 'python-shell-switch-to-shell))
(eval-after-load 'python
'(define-key python-mode-map (kbd "C-c |") 'python-shell-send-region))
