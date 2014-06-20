(require 'erc)
(require 'erc-services)
(require 'tls)

(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '((".*\\.freenode.net" "#emacs" "##linux")))

(erc-track-mode t)
(setq erc-track-mode-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                     "324" "329" "332" "333" "353" "477"))
                                        ;and hide this modes
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(defun djcb-erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?

    (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (erc :server "irc.freenode.net" :port 6667 :nick "xf0e" :full-name "Archibald Benlignton")
;;      (erc :server "irc.snoonet.org" :port 6667 :nick "xf0e" :full-name "Benlington, Archibald")
      )))
(global-set-key (kbd "C-c e") 'djcb-erc-start-or-switch) ;; ERC

;;colorise nicks
(defmacro unpack-color (color red green blue &rest body)
  `(let ((,red   (car ,color))
         (,green (car (cdr ,color)))
         (,blue  (car (cdr (cdr ,color)))))
     ,@body))

(defun rgb-to-html (color)
  (unpack-color color red green blue
   (concat "#" (format "%02x%02x%02x" red green blue))))

(defun hexcolor-luminance (color)
  (unpack-color color red green blue
   (floor (+ (* 0.299 red) (* 0.587 green) (* 0.114 blue)))))

(defun invert-color (color)
  (unpack-color color red green blue
   `(,(- 255 red) ,(- 255 green) ,(- 255 blue))))

(defun erc-get-color-for-nick (nick dark)
  (let* ((hash     (md5 (downcase nick)))
         (red      (mod (string-to-number (substring hash 0 10) 16) 256))
         (blue     (mod (string-to-number (substring hash 10 20) 16) 256))
         (green    (mod (string-to-number (substring hash 20 30) 16) 256))
         (color    `(,red ,green ,blue)))
    (rgb-to-html (if (if dark (< (hexcolor-luminance color) 85)
                       (> (hexcolor-luminance color) 170))
                     (invert-color color)
                   color))))

(defun erc-highlight-nicknames ()
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\w+" nil t)
      (let* ((bounds (bounds-of-thing-at-point 'word))
             (nick   (buffer-substring-no-properties (car bounds) (cdr bounds))))
        (when (erc-get-server-user nick)
          (put-text-property
           (car bounds) (cdr bounds) 'face
           (cons 'foreground-color (erc-get-color-for-nick nick 't))))))))

(add-hook 'erc-insert-modify-hook 'erc-highlight-nicknames)
