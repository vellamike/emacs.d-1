(autoload 'ibuffer "ibuffer")
(require 'ibuffer)

(eval-after-load "ibuffer"
  '(setq ibuffer-saved-filter-groups
         (quote (("default"
                  ("dired" (mode        . dired-mode))
                  ("org" (mode          . org-mode))
                  ("bio-seq" (or
                              (mode     . dna-mode)
                              (mode     . ralee-mode)
                              (mode  . bioseq-mode)))
                  ("perl" (or
                           (mode         . cperl-mode)
                           (mode         . perl-mode))
                           (name . "^\\.pl$"))
                  ("erc" (mode          . erc-mode))
                  ("shell script" (mode . sh-mode))
                  ("LaTeX" (mode        . latex-mode))
                  ("planner" (or
                              (name     . "^\\*Calendar\\*$")
                              (name     . "^diary$")
                              (mode     . muse-mode)))
                  ("python" (mode       . python-mode))
                  ("c/cpp" (or
                            (mode       . c-mode)
                            (mode       . c++-mode)))
                  ("R mode" (or
                            (name      . "^\\*R\\*$")
                            (name      . "^\\*ESS\\*$")
                            (name      . "\\.R$")
                            (mode      . ess-mode)))
                  ("emacs" (or
                           (name       . "^\\*scratch\\*$")
                           (name       . ".el")
                           (name       . "^\\*Messages\\*$")))
                  ("gnus" (or
                           (mode        . message-mode)
                           (mode        . bbdb-mode)
                           (mode         . mu4e:main)
                           (mode         . mu4e:view)
                           (mode        . mail-mode)
                           (mode        . gnus-group-mode)
                           (mode        . gnus-summary-mode)
                           (mode        . gnus-article-mode)
                           (name        . "^\\.bbdb$")
                           (name        . "^\\.newsrc-dribble"))))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

(with-eval-after-load 'ibuffer
          ;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
  (setq ibuffer-formats
	'((mark modified read-only " "
		(name 18 18 :left :elide)
		" "
		(size-h 9 -1 :right)
		" "
		(mode 16 16 :left :elide)
		" "
		filename-and-process))))


(provide 'ibuffer)
