;; (make-frame-invisible (selected-frame) t)
;; (defvar emacs-home-path "/media/tpd1/home/")
;; (load (expand-file-name ".emacs" emacs-home-path) t)
(defvar emacs-site-lisp-path
  (expand-file-name "site-lisp/" emacs-home-path))
(add-to-list 'load-path emacs-site-lisp-path)

(defun tataletak-jendela-personal ()
  (interactive)
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (set-face-attribute 'default nil
                      :background "black" :foreground "white")
  (column-number-mode 1))

(load "adh.el" t t t)
(setq user-mail-address "cadmus.sw at gmail.com")
(setq user-full-name "Adhi Hargo")
(add-hook 'write-file-hooks 'time-stamp)

(setq backup-by-copying t)
(setq w32-get-true-file-attributes nil)

(setq make-backup-files nil)
(define-key global-map (kbd "<f8>") 'compile)
(define-key global-map (kbd "<f9>") 'recompile)
(define-key global-map (kbd "C-x C-b") 'buffer-menu)
(setq compilation-window-height 12)

(add-hook 'window-setup-hook
          'tataletak-jendela-personal)

(global-set-key (kbd "M-n") 'woman)

;====================== Registrasi ekstensi file =====================
(setq auto-mode-alist
      (append
       '(
	 ("\\.go$" . go-mode)
	 ("\\.html$" . nxml-mode)
	 ("\\.hx$" . haxe-mode)
	 ("\\.ina$" . sh-mode)
	 ("\\.lua$" . lua-mode)
	 ("\\.md$" . markdown-mode)
	 ("\\.muse$" . muse-mode)
	 ;; ("\\.pde$" . processing-mode)
	 ("\\.proto$" . protobuf-mode)
	 ("\\.\\(php\\|x\\)bb$" . xbbcode-mode)
	 ("\\.pro$" . conf-unix-mode)
	 ("\\.pyw?$" . python-mode)
	 ("\\.rbw?$" . ruby-mode)
	 ("\\.text$" . markdown-mode)
	 ("^Doxyfile$" . makefile-mode)
	 ("CMakeLists\\.txt" . cmake-mode)
	 )
       auto-mode-alist))
;; (add-to-list 'auto-mode-alist '("\\.pro$" . conf-unix-mode))

;============================== Packages =============================
;; Keep above all other packages
(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;=============================== AucTeX ==============================
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (load "auctex.el" t t t)
	    (load "preview.el" t t t)
	    (turn-on-reftex)
	    (TeX-fold-mode 1)
	    (font-lock-mode '())))

;============================ Autocomplete ===========================
(defvar auto-complete-path
  (expand-file-name "auto-complete-1.3.1/" emacs-site-lisp-path))
(add-to-list 'load-path auto-complete-path) 
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-mode-map (kbd "<C-tab>") 'auto-complete)

;=============================== BBCode ==============================
(autoload 'xbbcode-mode "xbbcode-mode" nil t)

;============================= Bookmarks =============================
(autoload 'bm-toggle "bm.el" nil t)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)
(global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

;============================== CC Mode ==============================
(add-hook 'c-mode-hook
          (lambda ()
            (c-set-style "gnu")))
(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-style "gnu")))
(add-hook 'java-mode-hook
          (lambda ()
            (c-set-style "gnu")))

;=============================== CMake ===============================
(autoload 'cmake-mode "cmake-mode" nil t)

;=============================== Dired ===============================
(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)))
(add-hook 'dired-mode-hook 'auto-revert-mode)
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
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
              "\\|^missing$\\|^aclocal\\.m4$"     ; aclocal
              "\\|^depcomp$\\|^install-sh$"
              "\\|^autom4te\\.cache$"
              "\\|^config\\.\\(status\\|log\\|h\\.in\\)$"
              "\\|^stamp-h1$"
              "\\|\\.fasl$"             ; common lisp
              "\\|\\.cm.+$"             ; ocaml
              "\\|^\\."
              ))))

(setq
 dired-guess-shell-alist-user
 (list
  '("\\.pyw?$" "python2" "python3")
  '("\\.ui$" "designer" "designer-qt4")
  '(
    "\\.pdf$"
    (concat
     "gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sPAPERSIZE=a4"
     " -sOutputFile=\"" (file-name-sans-extension file) "-.pdf\""))
  ))

;============================== CC Mode ==============================
(add-hook 'c-mode-hook
          (lambda ()
            (c-set-style "gnu")))
(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-style "gnu")))
(add-hook 'java-mode-hook
          (lambda ()
            (c-set-style "gnu")))

;============================== Doxygen ==============================
(autoload 'doxymacs-mode "doxymacs" nil t)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
;================================= Go ================================
;; (require 'go-eldoc)
;; (add-hook 'go-mode-hook 'go-eldoc-setup)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(defun my-go-mode-hook ()
  ; Call Gofmt before saving
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding                                                      
  (local-set-key (kbd "M-.") 'godef-jump-other-window)
  (local-set-key (kbd "M-*") 'pop-tag-mark) )
(add-hook 'go-mode-hook 'my-go-mode-hook)

;================================ Git ================================
(autoload 'magit-status "magit" nil t)

;================================ Ido ================================
(setq ido-separator "\n") ;;; make ido display choices vertically
(setq ido-enable-flex-matching t) ;;; display any item that contains the chars you typed
(setq ido-mode 'buffer)

;=============================== iedit ===============================
(require 'iedit)

;================================ Lua ================================
(autoload 'lua-mode "lua-mode" nil t)
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;============================== Markdown =============================
(autoload 'markdown-mode "markdown-mode" nil t)

;================================ Muse ===============================
(autoload 'muse-mode "muse-mode" nil t)
(add-hook 'muse-mode-hook
          (lambda ()
            (load "muse-html.el" t t)
            (load "muse-latex.el" t t )
            (load "htmlize-hack.el" t t)))
(add-hook 'muse-mode-hook 'footnote-mode)

;========================== Multiple-Cursors =========================
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-c C-<") 'mc/mark-all-like-this)

;============================== org-mode =============================
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;================================ Nim ================================
(add-hook 'nim-mode-init-hook
          (lambda () (setq
                      compilation-error-regexp-alist
                      (append
                       '(
                         ("^\\(?:> \\)?\\(.*?\\)(\\([0-9]+\\)\\(?:, \\([0-9]+\\)\\)?) \\(Error:\\)" 1 2 3)
                         ("^Error: [^:]+: ?\\(.*?\\)(\\([0-9]+\\), \\([0-9]+\\))" 1 2 3)
                         )
                       compilation-error-regexp-alist))
            (electric-pair-mode)))

(add-hook 'nim-mode-init-hook
          (lambda ()
            (setq-local compile-command
                        (concat "make -k "
                                (if buffer-file-name
                                    (shell-quote-argument
                                     (concat (file-name-base buffer-file-name) ".exe")))))))

;================================ PHP ================================
(autoload 'php-mode "php-mode" nil t)

;=============================== Poporg ==============================
(autoload 'poporg-dwim "poporg" nil t)
(global-set-key (kbd "C-c \"") 'poporg-dwim)

;============================== Protobuf =============================
(autoload 'protobuf-mode "protobuf-mode" nil t)

;=============================== Python ==============================
(defvar python-mode-path
  (expand-file-name "python-mode.el-6.2.0/" emacs-site-lisp-path))
(add-to-list 'load-path python-mode-path) 
(setq py-install-directory python-mode-path)
(require 'python-mode)

(add-to-list 'completion-ignored-extensions ".pyc" t)

; don't split window without my consent
(setq py-keep-windows-configuration t)
; try to automagically figure out indentation
(setq py-smart-indentation t)

; refactoring tool for 2.x
(setq ropemacs-enable-shortcuts nil) 
(setq ropemacs-local-prefix "C-c C-p")
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

;==================== Scheme... Everything Scheme ====================
(load "quack.el" t t t)

;================================= VC ================================
;; Matikan VC, bikin lambat
(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))
(remove-hook 'find-file-hooks 'vc-find-file-hook)



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
 '(compilation-skip-visited nil)
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
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "Envy Code R"))))
 '(cursor ((t (:background "white"))))
 '(fixed-pitch ((t (:family "CourierPrime"))))
 '(fringe ((((class color) (background dark)) (:background "grey80" :foreground "black"))))
 '(mmm-code-submode-face ((t nil)))
 '(mmm-default-submode-face ((t (:background "gray10"))))
 '(muse-emphasis-1 ((t (:slant italic))))
 '(muse-emphasis-2 ((t (:foreground "brown4" :weight bold))))
 '(muse-emphasis-3 ((t (:foreground "yellow4" :slant italic :weight bold)))))

(put 'dired-find-alternate-file 'disabled nil)

(put 'narrow-to-region 'disabled nil)

(put 'narrow-to-page 'disabled nil)
