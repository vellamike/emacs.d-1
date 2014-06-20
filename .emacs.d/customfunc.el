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


;;reduce cruft in modeline
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))
(rename-modeline "undo-tree" undo-tree-mode "UT")
;;(rename-modeline "Wrap" Wrap "wrp")


(global-set-key (kbd "C-x g") 'webjump)
;;add duckduckgo search to webjump
(eval-after-load "webjump"
  '(add-to-list 'webjump-sites
                '("DuckDuckGo" .
                  [simple-query
                   "www.duckduckgo.org"
                   "https://duckduckgo.com/?q="
                   ""])))


(provide 'customfunc.el)
