
;;call g++ without makefile by default for flymake on cpp
(require 'flymake)
(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
(add-hook 'c++-mode-hook 'flymake-mode)


(defmacro flycheck-define-clike-checker (name command modes)
  `(flycheck-define-checker ,(intern (format "%s" name))
     ,(format "A %s checker using %s" name (car command))
     :command (,@command source-inplace)
     :error-patterns
     ((warning line-start (file-name) ":" line ":" column
               ": warning: " (message) line-end)
      (error line-start (file-name) ":" line ":" column
             ": error: " (message) line-end))
     :modes ',modes))
(flycheck-define-clike-checker c-gcc
                               ("gcc" "-fsyntax-only" "-Wall" "-Wextra")
                               c-mode)
(add-to-list 'flycheck-checkers 'c-gcc)


;; Better compile buffer ----------------------
(require 'compile)
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq
             compilation-scroll-output 'first-error  ; scroll until first error
             ;; compilation-read-command nil          ; don't need enter
             compilation-window-height 11)

            (local-set-key (kbd "<M-left>")   'previous-error)
            (local-set-key (kbd "<M-right>") 'next-error)

            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   ;; emulate make's .c.o implicit pattern rule, but with
                   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
                   ;; variables:
                   ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
                   (let ((file (file-name-nondirectory buffer-file-name)))
                     (format "%s -o %s %s %s"
                             (or (getenv "CC") "g++")
                             (file-name-sans-extension file)
                             ;;(or (getenv "CPPFLAGS") "-DDEBUG=9")
                             (or (getenv "CFLAGS") " -g -O2 -Wall -Wextra")
                             file)))))
          ;;(number of things in " " in format must match number of arg. in getenv.)

          ;;This will run Make if there is a Makefile in the same directory as the
          ;;source-file, or it will create a command for compiling a single
          ;;file and name the executable the same name as the file with the extension
          ;;stripped.
          )
;;---------------------------------------------

;;Navigate .h och .cpp ------------------------
;;Now, we can quickly switch between myfile.cc and myfile.h with C-c o.
;;Note the use of the c-mode-common-hook, so it will work for both C and C++.
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)))
;;--------------------------------------------

;;Fold code-block-----------------------------
(add-hook 'c-mode-common-hook
          (lambda()
            ;; Now same/similar to org-mode hirarcy, but collides with
            ;; my (previous) setting for next-error/previous-error
            (local-set-key (kbd "M-s") 'hs-show-block)
            (local-set-key (kbd "M-q") 'hs-hide-block)
            (local-set-key (kbd "M-<up>")    'hs-hide-all)
            (local-set-key (kbd "M-<down>")  'hs-show-all)

            ;;hide/show code-block
            (hs-minor-mode t)))
;;--------------------------------------------
