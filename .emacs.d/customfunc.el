;;open _idented_ line above current one
(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))
(global-set-key (kbd "M-o") 'smart-open-line-above)

;; only show line numbers while goto-line f. active
;; don't forget to remap the "goto-line" function
(defun goto-line-with-feedback ()
  "show line numbers temporarily, while prommpting for the line number input"
  (interactive)
   (unwind-protect
   (progn
     (linum-mode 1)
     (goto-line (read-number "Goto line: ")))
   (linum-mode -1)))


(defun my-expand-file-name-at-point ()
  "Use hippie-expand to expand the filename"
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name)))
    (call-interactively 'hippie-expand)))
(global-set-key (kbd "C-M-/") 'my-expand-file-name-at-point)


(global-set-key (kbd "C-x g") 'webjump)
;;add duckduckgo search to webjump
(eval-after-load "webjump"
  '(add-to-list 'webjump-sites
                '("DuckDuckGo" .
                  [simple-query
                   "www.duckduckgo.org"
                   "https://duckduckgo.com/?q="
                   ""])))


;;move selected region
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          (when (and (eval-when-compile
                       '(and (>= emacs-major-version 24)
                             (>= emacs-minor-version 3)))
                     (< arg 0))
            (forward-line -1)))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key [M-C-up] 'move-text-up)
(global-set-key [M-C-down] 'move-text-down)

(defun xah-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 in current buffer.
URL `http://ergoemacs.org/emacs/emacs_CSS_colors.html'
Version 2015-06-11"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer))

;;provide functionality of langtool for spellchecking
 (defun lcl:langtool ()
   (setq langtool-default-language "de"
         langtool-mother-tongue "de"
         ;;disable the morphological check, since it works only for 1 language
         ;;langtool-disabled-rules "MORFOLOGIK_RULE_RU_RU"
         langtool-java-classpath "/usr/share/java/languagetool/languagetool-commandline.jar
"))
 (lcl:langtool)

;remove spaces greedy.
(defun cfg:backward-delete-tab-whitespace ()
  (interactive)
  (let ((p (point)))
    (if (and (eq indent-tabs-mode nil)
             (>= p tab-width)
             (eq (% (current-column) tab-width) 0)
             (string-match "^\\s-+$" (buffer-substring-no-properties (- p tab-width) p)))
        (delete-backward-char tab-width)
      (delete-backward-char 1))))
(global-set-key (kbd "<backspace>") 'cfg:backward-delete-tab-whitespace)


(provide 'customfunc.el)
