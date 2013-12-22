;; (make-frame-invisible (selected-frame) t)
(defvar emacs-home-path "/media/D_PROGRAM/home/")
(defvar emacs-site-lisp-path
  (expand-file-name "site-lisp/" emacs-home-path))
(defvar emacs-site-lisp-subdirs
  (let ((dirlist
	 (mapcar (lambda (x) (expand-file-name x emacs-site-lisp-path))
		 '(
		   "auctex-11.84/preview/"
		   "muse-3.20/lisp/"
		   "muse-3.20/contrib/"
		   "doxymacs-1.8.0/no-autoconf/"
		   "mmm-mode-0.4.8"
                   "php-mode-1.4.0"
		   ))
	 ))
    (mapc (lambda (x)
	    (when (file-directory-p x) (push x dirlist)))
	  (directory-files emacs-site-lisp-path t))
    dirlist))
(setq
 load-path (append (list emacs-site-lisp-path)
                   load-path		   
		   emacs-site-lisp-subdirs
		   ))

(defun tataletak-jendela-personal ()
  (interactive)
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (set-face-attribute 'default nil
  		      :background "black" :foreground "white")
  (column-number-mode 1)
  )

(load "adh.el" t t t)
(setq user-mail-address "cadmus.sw at gmail.com")
(setq user-full-name "Adhi Hargo")
(add-hook 'write-file-hooks 'time-stamp)

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(setq make-backup-files nil)
(define-key global-map (kbd "<f8>") 'compile)
(setq compilation-window-height 12)

;; ---------------------- Registrasi ekstensi file ----------------------
(setq auto-mode-alist
      (append
       '(
	 ;; ("\\.\\(cmd\\|bat\\)$" . cmd-mode)
	 ("\\.antlr$" . antlr-mode)
	 ;; ("\\.as$" . actionscript-mode)
	 ;; ("\\.asm$" . nasm-mode)
	 ;; ("\\.cs$" . csharp-mode)
	 ("\\.f$" . forth-mode)
	 ("\\.grid$" . conf-windows-mode)
	 ("\\.go$" . go-mode)
	 ;; ("\\.h\\(i\\|sc?\\)$" . haskell-mode)
	 ("\\.html$" . nxml-mode)
	 ("\\.hx$" . haxe-mode)
	 ("\\.ina$" . sh-mode)
	 ;; ("\\.js$" . javascript-mode)
	 ;; ("\\.lhs$" . literate-haskell-mode)
	 ("\\.lua$" . lua-mode)
	 ;; ("\\.ml[iylp]?$" . tuareg-mode)
	 ("\\.md$" . markdown-mode)
	 ("\\.muse$" . muse-mode)
	 ;; ("\\.pde$" . processing-mode)
	 ("\\.proto$" . protobuf-mode)
	 ("\\.\\(php\\|x\\)bb$" . xbbcode-mode)
	 ;; ("\\.pov$" . pov-mode)
	 ("\\.pro$" . conf-unix-mode)
	 ("\\.pyw?$" . python-mode)
	 ("\\.rbw?$" . ruby-mode)
	 ("\\.text$" . markdown-mode)
	 ("^Doxyfile$" . makefile-mode)
	 ("CMakeLists\\.txt" . cmake-mode)
	 )
       auto-mode-alist))
;; (add-to-list 'auto-mode-alist '("\\.pro$" . conf-unix-mode))

(add-hook 'window-setup-hook
	  'tataletak-jendela-personal)

(global-set-key (kbd "M-n") 'woman)

;; =============================== AucTeX ===============================
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (load "auctex.el" t t t)
	    (load "preview.el" t t t)
	    (turn-on-reftex)
	    (TeX-fold-mode 1)
	    (font-lock-mode '())))

;; =============================== BBCode ===============================
(autoload 'xbbcode-mode "xbbcode-mode" nil t)

;; ============================== Bookmarks =============================
(autoload 'bm-toggle "bm.el" nil t)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)
(global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

;; =============================== CC Mode ==============================
(add-hook 'c-mode-hook
	  (lambda ()
	    (c-set-style "gnu")))
(add-hook 'c++-mode-hook
	  (lambda ()
	    (c-set-style "gnu")))
(add-hook 'java-mode-hook
	  (lambda ()
	    (c-set-style "gnu")))

;; ================================ CEDET ===============================
;; (semantic-add-system-include 
;;  "/usr/include/qt4" 'c++-mode)
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file
;; 	     "/usr/include/qt4/Qt/qconfig.h")
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file
;; 	     "/usr/include/qt4/Qt/qconfig-dist.h")

;; ================================ CMake ===============================
(autoload 'cmake-mode "cmake-mode" nil t)

;; ================================ Dired ===============================
(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-omit-mode 1)))
(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")
	    (setq
	     dired-listing-switches "--group-directories-first -lhagG"
	     dired-omit-files
	     (concat
	      "^\\.?#\\|^\\.$\\|^\\.\\.$"
	      "\\|^Makefile\\(\\.am\\|\\.in\\)?$" ; automake
	      "\\|^configure\\(\\.ac\\|\\.in\\)?" ; autoconf
	      "\\|^missing$\\|^aclocal\\.m4$"	  ; aclocal
	      "\\|^depcomp$\\|^install-sh$"
	      "\\|^autom4te\\.cache$"
	      "\\|^config\\.\\(status\\|log\\|h\\.in\\)$"
	      "\\|^stamp-h1$"
	      "\\|\\.fasl$"		; common lisp
	      "\\|\\.cm.+$"		; ocaml
	      "\\|^\\."
	      ))))

(setq
 dired-guess-shell-alist-user
 (list
  '(
    "\\.pdf$"
    (concat
     "gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sPAPERSIZE=a4"
     " -sOutputFile=\"" (file-name-sans-extension file) "-.pdf\""))
  ))

;; =============================== Doxygen ==============================
(autoload 'doxymacs-mode "doxymacs" nil t)
(add-hook 'c-mode-common-hook 'doxymacs-mode)

;; ================================= Git ================================
(autoload 'magit-status "magit" nil t)

;; ================================= Lua ================================
(autoload 'lua-mode "lua-mode" nil t)
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; ============================== Markdown ==============================
(autoload 'markdown-mode "markdown-mode" nil t)

;; ================================ Muse ================================
(autoload 'muse-mode "muse-mode" nil t)
(add-hook 'muse-mode-hook
	  (lambda ()
	    (load "muse-html.el" t t)
	    (load "muse-latex.el" t t )
	    (load "htmlize-hack.el" t t)))
(add-hook 'muse-mode-hook 'footnote-mode)

;; ================================= PHP ================================
(autoload 'php-mode "php-mode" nil t)

;; ============================== Protobuf ==============================
(autoload 'protobuf-mode "protobuf-mode" nil t)

;; =============================== Python ===============================
;; pymacs
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; bicyclerepair
;; (pymacs-load "bikeemacs" "brm-")

;; ===================== Scheme... Everything Scheme ====================
(load "quack.el" t t t)



;; ======================================================================
;; ======================================================================
;; ============== JANGAN GANGGU KONFIGURASI DI BAWAH INI!!! =============
;; ======================================================================
;; ======================================================================

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(Info-fontify-visited-nodes nil)
 '(Info-hide-note-references nil)
 '(Info-isearch-search nil)
 '(Man-notify-method (quote pushy))
 '(c-basic-offset 8)
 '(c-default-style "gnu")
 '(column-number-mode t)
 '(comint-prompt-read-only t)
 '(comment-empty-lines t)
 '(comment-multi-line t)
 '(comment-style (quote multi-line))
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error t)
 '(compilation-disable-input t)
 '(compilation-scroll-output (quote first-error))
 '(compilation-skip-visited t)
 '(debug-on-error nil)
 '(display-buffer-reuse-frames t)
 '(doc-view-ghostscript-options (quote ("-dSAFER" "-dNOPAUSE" "-sDEVICE=png16m" "-dTextAlphaBits=4" "-dBATCH" "-dGraphicsAlphaBits=4" "-dQUIET" "-dUseCropBox")))
 '(haskell-indent-after-keywords (quote ("where" "of" "do" "in" "{" "if" "then" "else" "let")))
 '(haskell-indent-rhs-align-column 8)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ls-lisp-dirs-first t)
 '(ls-lisp-ignore-case t)
 '(ls-lisp-verbosity nil)
 '(quack-default-program "gsi")
 '(quack-programs (quote ("gauche" "bigloo" "csi" "csi -hygienic" "gosh" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mred -z" "mzscheme" "mzscheme -M errortrace" "mzscheme -b" "mzscheme -i" "petite" "rs" "scheme" "scheme48" "scm" "scsh" "sisc" "stklos" "sxi")))
 '(reftex-plug-into-AUCTeX t)
 '(rng-nxml-auto-validate-flag nil)
 '(safe-local-variable-values (quote ((noweb-doc-mode . nxml-mode) (noweb-doc-mode . markdown-mode) (noweb-doc-mode . doc-mode) (noweb-doc-mode . latex-mode) (noweb-code-mode . asm86-mode) (major-mode . c-mode) (dired-omit-mode . t) (dired-omit-files . "lexer.ml"))))
 '(scroll-bar-mode nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "Envy Code R"))))
 '(cursor ((t (:background "white"))))
 '(fringe ((((class color) (background dark)) (:background "grey80" :foreground "black"))))
 '(mmm-code-submode-face ((t nil)))
 '(mmm-default-submode-face ((t (:background "gray10"))))
 '(muse-emphasis-1 ((t (:slant italic))))
 '(muse-emphasis-2 ((t (:foreground "brown4" :weight bold))))
 '(muse-emphasis-3 ((t (:foreground "yellow4" :slant italic :weight bold)))))

(put 'dired-find-alternate-file 'disabled nil)

(put 'narrow-to-region 'disabled nil)

(put 'narrow-to-page 'disabled nil)
