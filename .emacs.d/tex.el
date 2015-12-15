;(load-file "/usr/share/emacs/site-lisp/auctex.el")
;(load-file "/usr/share/emacs/site-lisp/auctex/preview.elc")

(when (require 'smartparens nil 'noerror)
  (require 'smartparens-latex))

;; ;;; make AUCTeX aware of style files and multi-file documents
(add-hook 'LaTeX-mod-hook
          '(lambda ()
             (setq LaTeX-syntactic-comment t)
             (setq TeX-auto-untabify t)
             (setq-default TeX-engine 'xelatex)
             (setq TeX-PDF-mode t) ; Use pdflatex by default
             (setq TeX-auto-save t) ; recommended in quickstart
             (setq TeX-parse-self t) ; recommended in quickstart
             (setq font-latex-verbatim-environments '("verbatim" "verbatim*" "lstlisting"))
             (setenv "TEXINPUTS" ".:/home/grrr/doc/.latex/:")
             ))

;; ;;RefTeX--------------------------------------
;; ;;Navigate sections by right mouse button. (Similar to as C-c =)
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)            ;;with AUCTeX LaTeX mode
(autoload 'reftex-mode    "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" t)
;; ;; To integrate RefTex even closer with AUCTeX.  E.g: when C-c C-s
;; ;; or C-c C-e is called, AUCTex will call RefTeX, which will insert
;; ;; a label automatically instead of having AUCTeX ask you for one;
;; ;; When C-c C-s AUCTeX will update section list in RefTeX; RefTeX
;; ;; will also tell AUCTeX about new label, citation, and index keys,
;; and add them to completions list.
(setq reftex-plug-into-AUCTeX t)
;;Make C-u prefixed commands not re-parse entire doc.
(setq reftex-enable-partial-scans t)



(setq LaTeX-section-hook
       '(LaTeX-section-heading
       LaTeX-section-title
       LaTeX-section-toc
        LaTeX-section-section
         LaTeX-section-label))

(setq reftex-plug-into-AUCTeX t)
;;Zeilenumbruch
(add-hook 'TeX-mode-hook 'turn-on-auto-fill)
;; Mathe Modus
(add-hook 'TeX-mode-hook 'LaTeX-math-mode)
;no master file
(setq-default TeX-master nil)
;;(add-hook 'TeX-mode-hook 'visual-line-mode)
;;;highligt misspelled words
(add-hook 'TeX-mode-hook 'flyspell-mode)

(add-hook 'TeX-mode-hook (lambda()
                             (add-to-list  'TeX-command-list '("XeLaTeX" "xelatex -interaction=nonstopmode %s" TeX-run-command t t :help "Run xelatex") t)
                             (setq TeX-command-default “XeLaTeX”)
                             (setq TeX-save-query nil)
                             (setq TeX-show-compilation t)))


;;preview on the right page
(setq TeX-view-program-list '(("Okular" "okular --page=%(outpage) %o")))
(setq TeX-view-program-selection '((output-pdf "Okular")))
(add-hook 'TeX-mode-hook 'TeX-source-specials-mode)
(setq TeX-source-correlate-start-server t)


;;;Smart quotes ' "
(defadvice TeX-insert-quote (around wrap-region activate)
  (cond
   (mark-active
    (let ((skeleton-end-newline nil))
      (skeleton-insert `(nil ,TeX-open-quote _ ,TeX-close-quote) -1)))
   ((looking-at (regexp-opt (list TeX-open-quote TeX-close-quote)))
    (forward-char (length TeX-open-quote)))
   (t
    ad-do-it)))
(put 'TeX-insert-quote 'delete-selection nil)
;;;Inserting and wraping single quotes
(defun TeX-insert-single-quote (arg)
  (interactive "p")
  (cond
   (mark-active
    (let ((skeleton-end-newline nil))
      (skeleton-insert
       `(nil ?` _ ?') -1)))
   ((or (looking-at "\\<")
        (looking-back "^\\|\\s-\\|`"))
    (insert "`"))
   (t
    (self-insert-command arg))))

(add-hook 'LaTeX-mode-hook
          '(lambda ()
             (local-set-key "'" 'TeX-insert-single-quote)))

  (add-hook 'TeX-mode-hook
            (lambda ()
              (outline-minor-mode t)
              (flyspell-mode t)
              (TeX-interactive-mode t)
              (TeX-PDF-mode t)
              (TeX-fold-mode t)))

  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (LaTeX-math-mode t)
              (reftex-mode t)))

  (add-hook 'reftex-toc-mode-hook
            (lambda ()
              (when (featurep 'evil)
                (turn-off-evil-mode))))

(defvar ome-LaTeX-shell-escape-mode nil
  "Whether or not LaTeX shell escape mode is enabled.")

(defun ome-LaTeX-toggle-shell-escape ()
  (interactive)
  (if ome-LaTeX-shell-escape-mode
      (progn
        (setcdr (assoc "LaTeX" TeX-command-list)
                '("%`%l%(mode)%' %t"
                  TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX"))
        (setq ome-LaTeX-shell-escape-mode nil)
        (message "LaTeX shell escape mode turned off."))
    (progn
      (setcdr (assoc "LaTeX" TeX-command-list)
              '("%`%l%(mode) -shell-escape%' %t"
                TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))
    (setq ome-LaTeX-shell-escape-mode t)
    (message "LaTeX shell escape mode turned on.")))

;; (define-key org-mode-map (kbd "C-c C-x x") 'ome-LaTeX-toggle-shell-escape)


(defun ome-cdlatex-mode-setup ()
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
  (add-hook 'latex-mode-hook 'turn-on-cdlatex))



;Improving LaTeX equations with font-lock
(defun endless/unimportant-latex-face
  '((t :height 0.6
       :inherit font-lock-comment-face))
  "Face used on less relevant math commands.")

(font-lock-add-keywords
 'latex-mode
 `((,(rx "\\" (or (any ",.!;")
                  (and (or "left" "right")
                       symbol-end)))
    0 'endless/unimportant-latex-face prepend))
 'end)
