;;; org-mode
(require 'org)
(setq org-completion-use-ido t)
;(require 'org-special-blocks)
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
;set pass
;(setq org-mobile-encryption-password "&&&&&&&&")
;;transparent encrypt
;(require 'epa-file)
;(epa-file-enable)
;(setq epa-armor t)
;(setq org-mobile-inbox-for-pull "~/notes/org/inbox.org")


(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   (org . t)
   (emacs-lisp . t)
   (python . t)
   (R . t)
   (latex .t)
   (gnuplot . t)))
(setq org-confirm-babel-evaluate nil)
(setf org-babel-default-header-args:org '((:exports . "code")))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/todo.org") "Tasks")
         "* TODO %?\n %i\n")
        ("f" "Link" plain (file (concat org-directory "/fav.org"))
         "- %?\n %x\n")
         ("r" "add book to read" checkitem (file (concat org-directory "/want_read.org"))
          "[ ] %?\n %i\n")
         ))

;;; latex
(setq org-export-latex-listings t)
(setq org-export-to-pdf-process 'xelatex)
;; Originally taken from Bruno Tavernier: http://thread.gmane.org/gmane.emacs.orgmode/31150/focus=31432
;; but adapted to use latexmk 4.20 or higher.
(defun my-auto-tex-cmd ()
  "When exporting from .org with latex, automatically run latex,
     pdflatex, or xelatex as appropriate, using latexmk."
  (let ((texcmd)))
  ;; default command: oldstyle latex via dvi
  (setq texcmd "latexmk -dvi -pdfps -quiet %f")
  ;; pdflatex -> .pdf
  (if (string-match "LATEX_CMD: pdflatex" (buffer-string))
      (setq texcmd "latexmk -pdf -quiet %f"))
  ;; xelatex -> .pdf
  (if (string-match "LATEX_CMD: xelatex" (buffer-string))
      (setq texcmd "latexmk -pdflatex=xelatex -pdf -quiet %f"))
  ;; LaTeX compilation command
  (setq org-latex-to-pdf-process (list texcmd)))

(add-hook 'org-export-latex-after-initial-vars-hook 'my-auto-tex-cmd)


;; Specify default packages to be included in every tex file, whether pdflatex or xelatex
(setq org-export-latex-packages-alist
      '(("" "graphicx" t)
            ("" "longtable" nil)
            ("" "float" nil)))

(defun my-auto-tex-parameters ()
      "Automatically select the tex packages to include."
      ;; default packages for ordinary latex or pdflatex export
      (setq org-export-latex-default-packages-alist
             '( (""     "fixltx2e"  nil)
              (""     "wrapfig"   nil)
              (""     "soul"      t)
              (""     "textcomp"  t)
              (""     "marvosym"  t)
              (""     "wasysym"   t)
              (""     "latexsym"  t)
              (""     "amssymb"   t)
              (""     "hyperref"  nil)))

      ;; Packages to include when xelatex is used
      (if (string-match "LATEX_CMD: xelatex" (buffer-string))
          (setq org-export-latex-default-packages-alist
                '(("" "fontspec" t)
                  ("" "xunicode" t)
                  ("" "url" t)
                  ("" "rotating" t)
                  ("german" "babel" t)
                  ("babel" "csquotes" t)
                  ("" "soul" t)
                  ("xetex" "hyperref" nil)
                  )))

      (if (string-match "LATEX_CMD: xelatex" (buffer-string))
          (setq org-export-latex-classes
                (cons '("article"
                        "\\documentclass[11pt,article,oneside]{memoir}"
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                      org-export-latex-classes))))

(add-hook 'org-export-latex-after-initial-vars-hook 'my-auto-tex-parameters)

(eval-after-load "org"
  '(progn
     ;; Change .pdf association directly within the alist
     (setcdr (assoc "\\.pdf\\'" org-file-apps) "okular %s")))

(setq org-startup-indented t); Use virtual indentation for all files

;;table caption below table
(setq org-export-latex-table-caption-above nil)



;a progress indicator for code blocks in org-mode
;; give us some hint we are running
(defadvice org-babel-execute-src-block (around progress nil activate)
  (set-face-attribute
   'org-block-background nil :background "LightSteelBlue")
  (message "Running your code block")
  ad-do-it
  (set-face-attribute 'org-block-background nil :background "gray")
  (message "Done with code block"))
