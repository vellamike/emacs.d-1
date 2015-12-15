(add-to-list 'auto-mode-alist '("\\.fasta" . dna-mode))
(add-to-list 'auto-mode-alist '("\\.fst" . dna-mode))
(add-to-list 'auto-mode-alist '("\\.fst" . bioseq-mode))
(add-to-list 'auto-mode-alist '("\\.fst" . biseq-mode))
(add-to-list 'load-path "~/.emacs.d/site-lisp/ralee-0.7/elisp")
   ;-------
   ;; ralee mode is good for RNA alignment editing
   (autoload 'ralee-mode "ralee-mode" "Yay! alignment things" t)
   (setq auto-mode-alist (cons '("\\.stk$" . ralee-mode) auto-mode-alist))
   ;-------
