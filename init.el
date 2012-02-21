(tool-bar-mode -1)
(when (string-equal system-type "darwin")
  (progn
    (set-default-font "Consolas 14")
    (set-face-font 'mode-line  "Lucida Grande-12")
    ;; key mappings on Emacs Cocoa (Mac)
    (setq ns-command-modifier 'meta)
    (setq ns-option-modifier 'control)))

(when (string-equal system-type "gnu/linux")
  (progn
    (set-default-font "Monospace 11")))

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "/usr/share/emacs/site-lisp")

(fset 'yes-or-no-p 'y-or-n-p)
(setq vc-handled-backends ())

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(setq el-get-sources
      '((:name wrap-region
	       :after (wrap-region-global-mode t))
	;(:name autopair
	;       :after (lambda () (autopair-global-mode)))
	(:name yasnippet
	       :type git
	       :url "https://github.com/capitaomorte/yasnippet"
	       :after (lambda () (progn
							   (require 'yasnippet)
							   (yas/global-mode 1))))
	;; (:name color-theme-twilight
	;;        :after (color-theme-twilight))
	(:name ace-jump-mode
	       :after (lambda () (global-set-key (kbd "C-c SPC") 'ace-jump-mode)))
	; (:name slime
	; 	   :load-path ("." "contrib"))
	;; (:name highlight-symbol
	;;        :after (lambda ()
	;; 		(global-set-key [f10] 'highlight-symbol-at-point)
	;; 		(global-set-key [f11] 'highlight-symbol-next)
	;; 		(global-set-key [f12] 'highlight-symbol-prev)))
	(:name magit
	       :after (lambda () (global-set-key (kbd "C-x g") 'magit-status)))))
(setq my-packages
      (append '(el-get
		switch-window
		color-theme
		deft
		slime
		auto-complete
		auto-complete-clang
		haskell-mode
		xcscope
		python)
		(mapcar 'el-get-source-name el-get-sources)))
(el-get 'sync my-packages)

;; (set-face-attribute 'default nil :family "Monaco" :height 130)
;; (set-face-attribute 'default nil :family "Inconsolata" :height 130)
;; (set-face-attribute 'font-lock-comment-face nil
;; 		    :family "Inconsolata" :height 160 :slant 'italic
;; 		    :background "#ffffff"
;; 		    :foreground "#444444")
;; use utf-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; yank and indent
;; (dolist (command '(yank yank-pop))
;;   (eval `(defadvice ,command (after indent-region activate)
;; 	   (and (not current-prefix-arg)
;; 		(member major-mode
;; 			'(emacs-lisp-mode
;; 			  lisp-mode
;; 			  clojure-mode    scheme-mode
;; 			  haskell-mode    ruby-mode
;; 			  rspec-mode      python-mode
;; 			  c-mode          c++-mode
;; 			  objc-mode       latex-mode
;; 			  plain-tex-mode))
;; 		(let ((mark-even-if-inactive transient-mark-mode))
;; 		  (indent-region (region-beginning) (region-end) nil))))))

(when window-system (tool-bar-mode -1))
(delete-selection-mode 1)
(global-visual-line-mode 1)
;; (global-linum-mode 1)
;; (setq linum-format "%d ")
(setq inhibit-startup-message t)
;; (setq make-backup-files nil)
;; (setq trash-directory (expand-file-name "~/.Trash")
;;       delete-by-moving-to-trash t)

;; (when window-system (speedbar 1))

; (add-to-list 'load-path "~/.emacs.d/icicles")
; (require 'icicles)
; (icy-mode 1)

(require 'epa-file)
(epa-file-enable)

(add-hook 'dired-load-hook '(lambda ()
			      (require 'dired-x)
			      (setq dired-omit-files-p t)
			      (setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))))

;; (autoload 'gtags-mode "gtags" "" t)

;; (require 'ctab)
;; (ctab-mode t)
;; (setq ctab-smart t)

;; (require 'ido)

;; git
(setenv "PATH" (concat "/usr/local/bin" path-separator (getenv "PATH")))
(setq exec-path (append exec-path '("/usr/local/bin")))
; (require 'git)
; (require 'git-blame)

;; general emacs settings
; (add-to-list 'default-frame-alist '(height . 40))
; (add-to-list 'default-frame-alist '(width . 80))
;;(add-to-list 'default-frame-alist '(alpha 95 95))
;;(add-to-list 'default-frame-alist '(cursor-type . bar))
;;(add-to-list 'default-frame-alist '(font . "Menlo-12"))
;;(setq-default tab-width 4)
(column-number-mode t)
(show-paren-mode t)
(setq case-replace t)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; (require 'tabbar)
;; (tabbar-mode 1)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed t) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse t) ;; scroll window under mouse    
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; mac open file
(if (string-equal system-type "darwin")
    (progn (define-key global-map [ns-drag-file] 'my-ns-open-files)))

; (load-theme 'misterioso)

;; font
;; (defun my-setup-frame (&rest frame)
;;  (if (display-graphic-p)
;;      (progn
;;        (load-theme 'misterioso)
;;        (set-frame-font (case system-type
;; 		       ('darwin "Inconsolata-16")
;; 		       ('gnu/linux "Monospace-12"))))))
;; (add-hook 'after-make-frame-functions 'my-setup-frame t)

(defun my-ns-open-files ()
  "Open files in the list `ns-input-file'."
  (interactive)
  (mapc 'find-file ns-input-file)
  (setq ns-input-file nil))

;; (load-file "~/.emacs.d/color-theme-monokai.el")
;; (color-theme-monokai)

;; copy & paste
;; (defun copy-from-osx ()
;;   (shell-command-to-string "pbpaste"))

;; (defun paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil)) 
;;       (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;         (process-send-string proc text)
;;         (process-send-eof proc))))

;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)

;; spell check settings
;; It works!  It works!  After two hours of slogging, it works!
(if (file-exists-p "/usr/local/bin/hunspell")                                         
    (progn
      (setq ispell-program-name "/usr/local/bin/hunspell")
      (eval-after-load "ispell"
        '(progn (defun ispell-get-coding-system () 'utf-8)))))
(autoload 'wcheck-mode "wcheck-mode"
    "Toggle wcheck-mode." t)
  (autoload 'wcheck-change-language "wcheck-mode"
    "Switch wcheck-mode languages." t)
  (autoload 'wcheck-actions "wcheck-mode"
    "Open actions menu." t)
  (autoload 'wcheck-jump-forward "wcheck-mode"
    "Move point forward to next marked text area." t)
  (autoload 'wcheck-jump-backward "wcheck-mode"
    "Move point backward to previous marked text area." t)
(global-set-key (kbd "C-c w c") 'wcheck-mode)
(global-set-key (kbd "C-c w l") 'wcheck-change-language)
(global-set-key (kbd "C-c w a") 'wcheck-actions)
(global-set-key (kbd "C-c w n") 'wcheck-jump-forward)
(global-set-key (kbd "C-c w p") 'wcheck-jump-backward)

(setq wcheck-language-data
      '(("US English"
	 (program . "/usr/local/bin/enchant")
	 (args "-l" "-d" "en_US")
	 (action-program . "/usr/local/bin/enchant")
	 (action-args "-a" "-d" "en_US")
	 (action-parser . enchant-suggestions-menu))))
(setq-default wcheck-language "US English")
(defun enchant-suggestions-menu (marked-text)
    (cons (cons "[Add to dictionary]" 'enchant-add-to-dictionary)
          (wcheck-parser-ispell-suggestions)))
(defvar enchant-dictionaries-dir "~/.config/enchant")

  (defun enchant-add-to-dictionary (marked-text)
    (let* ((word (aref marked-text 0))
           (language (aref marked-text 4))
           (file (let ((code (nth 1 (member "-d" (wcheck-query-language-data
                                                  language 'action-args)))))
                   (when (stringp code)
                     (concat (file-name-as-directory enchant-dictionaries-dir)
                             code ".dic")))))

      (when (and file (file-writable-p file))
        (with-temp-buffer
          (insert word) (newline)
          (append-to-file (point-min) (point-max) file)
          (message "Added word \"%s\" to the %s dictionary"
                   word language)))))

;; (setq ispell-program-name "/usr/local/bin/aspell")
;; (setq ispell-list-command "list")
;; (setq ispell-extra-args '("--sug-mode=ultra"))

;; (setq flyspell-issue-message-flag nil)
;; (global-set-key (kbd "C-c j") 'flyspell-check-previous-highlighted-word)
(add-hook 'text-mode-hook
	  (lambda ()
	    (wcheck-mode t)))

;; cedet
;;(load-file "~/.emacs.d/cedet-1.0pre7/common/cedet.el")
;;(semantic-load-enable-minimum-features)

;; ecb
;;(add-to-list 'load-path "~/.emacs.d/ecb")
;;(require 'ecb)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("04fd52af504d80a42d9487e3e6aa96b6937255d1" default)))
 '(gud-gdb-command-name "gdb --annotate=1")
 '(ido-enable-flex-matching t)
 '(ido-mode nil nil (ido))
 '(large-file-warning-threshold nil)
 '(org-agenda-files (quote ("~/org/sharing-cases.org" "~/org/isl.org" "~/org/polyhedral.org" "~/org/todo.org")))
 '(safe-local-variable-values (quote ((TeX-master . "paper"))))
 '(send-mail-function (quote sendmail-send-it)))

;; auto-complete
(require 'auto-complete-config)
(require 'auto-complete-clang)
; (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
;; (require 'auto-complete-etags)
(setq clang-completion-suppress-error 't
      ac-auto-start nil
      ac-dwim t)
(add-to-list 'ac-sources '(ac-source-yasnippet))
(ac-config-default)
;; (global-set-key "\M-/" 'auto-complete)

(defface ac-yasnippet-candidate-face
  '((t (:background "sandybrown" :foreground "black")))
  "Face for yasnippet candidate.")
 
(defface ac-yasnippet-selection-face
  '((t (:background "coral3" :foreground "white")))
  "Face for the yasnippet selected candidate.")
 
; (defvar ac-source-yasnippet
;   '((candidates . ac-yasnippet-candidate)
;     (action . yas/expand)
;     (candidate-face . ac-yasnippet-candidate-face)
;     (selection-face . ac-yasnippet-selection-face))
;   "Source for Yasnippet.")

(defun auto-complete-settings ()
  "Settings for `auto-complete'."
  ;; After do this, isearch any string, M-: (match-data) always
  ;; return the list whose elements is integer
  (global-auto-complete-mode 1)
  (setq ac-auto-start nil)
  ;; (define-key ac-complete-mode-map "<return>" nil)
  ;; (define-key ac-complete-mode-map "RET" nil)
  ;; (define-key ac-complete-mode-map "M-j" 'ac-complete)
  ;; (define-key ac-complete-mode-map "<C-return>" 'ac-complete)
  ;; (define-key ac-complete-mode-map "M-n" 'ac-next)
  ;; (define-key ac-complete-mode-map "M-p" 'ac-previous)
 
  (setq ac-dwim t)
 
  (set-default 'ac-sources
               '(ac-source-semantic
                 ac-source-yasnippet
                 ac-source-abbrev
                 ac-source-words-in-buffer
                 ac-source-words-in-same-mode-buffers
                 ac-source-imenu
                 ac-source-files-in-current-dir
                 ;ac-source-filename
		 )))
 
;; (eval-after-load "auto-complete"
;;   '(auto-complete-settings))

(require 'cc-mode)
(defun my-c-mode-common-hook ()
  ;;(setq indent-tabs-mode nil)
  (setq c-default-style '((java-mode . "java") (other . "linux")))
  (setq c-basic-offset 4)
  (c-set-offset 'inextern-lang 0)
  (c-toggle-hungry-state 1) ; hungry delete
  ;;(c-toggle-auto-state 1) ; auto newline
  (setq ac-auto-start nil)
  (setq ac-expand-on-auto-complete nil)
  (setq ac-quick-help-delay 0.3)
  (define-key c-mode-base-map (kbd "M-/") 'ac-complete-clang)
  ;;(gtags-mode 1)
  )
(defun my-c-mode-hook ())
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;; cdlatex
;;(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
;;(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)

;; auctex latex
(add-to-list 'exec-path "/usr/texbin")
(setenv "PATH" (concat "/usr/texbin" path-separator (getenv "PATH")))
(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)
(add-hook 'LaTeX-mode-hook (lambda ()
			     ;;(cdlatex-mode t)
			     (wcheck-mode t)
			     (TeX-fold-mode t)
			     (auto-fill-mode t)
			     ;;(setq TeX-electric-sub-and-superscript 0)
			     (turn-on-reftex)
			     (setq reftex-plug-into-AUCTeX t)
			     (setq reftex-label-alist '(AMSTeX))
			     (setq reftex-save-parse-info t)
			     (setq reftex-enable-partial-scans t)
			     (setq reftex-use-multiple-selection-buffers t)
			     (setq TeX-source-correlate-mode t)
			     (setq TeX-source-correlate-method 'synctex)
			     (setq TeX-master nil)
			     (setq TeX-save-query nil)
			     (add-to-list 'TeX-expand-list '("%u" okular-make-url))
			     (add-to-list 'TeX-expand-list '("%q" skim-make-url)))
	  )
 
(defun okular-make-url () (concat
		"file://"
		(expand-file-name (funcall file (TeX-output-extension) t)
			(file-name-directory (TeX-master-file)))
		"#src:"
		(TeX-current-line)
		(TeX-current-file-name-master-relative)))
 
(defun skim-make-url () (concat
		(TeX-current-line)
		" "
		(expand-file-name (funcall file (TeX-output-extension) t)
			(file-name-directory (TeX-master-file)))
		" "
		(buffer-file-name)))
 
(setq TeX-view-program-list 
      '(("Okular" "okular --unique %u")
	("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %q")))

(setq TeX-view-program-selection
      (case system-type 
	('gnu/linux '((output-pdf "Okular") (output-dvi "Okular")))
	('darwin '((output-pdf "Skim"))))) 

(server-start)

;; org-mode
(setq org-log-done t)
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "notes.org"))
;; (setq org-todo-keywords
;;       '((sequence
;; 	 "TODO(t)"
;; 	 "NEXT(n)"
;; 	 "STARTED(s)"
;; 	 "|" "DONE(d!/!)" "CANCELLED(c@/!)")
;; 	(sequence "INBOX")))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "todo.org" "Tasks")
	 "* TODO %?\n%i\nAdded: %U\nFrom: %a")
	("n" "Note" entry (file+datetree "notes.org")
	 "* %?\n%i\nAdded: %U\nFrom: %a")))
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cr" 'org-remember)
(global-set-key "\C-cl" 'org-store-link)
(add-hook 'org-mode-hook (lambda ()
			   (wcheck-mode t)
			   ;(setq truncate-lines nil)
			   (org-indent-mode t)))
(setq org-publish-project-alist
      '(("note-org"
         :base-directory "~/org"
	 :publishing-directory "~/org/html"
	 :base-extension "org"
         :recursive t
	 :exclude "html"
         :publishing-function org-publish-org-to-html
         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "Yi Zhang's Notes"
         :link-home "index.html"
         :section-numbers nil
         :style "<link rel=\"stylesheet\"href=\"./style/worg.css\"type=\"text/css\"/>")
        ("note-static"
         :base-directory "~/org"
         :publishing-directory "~/org/html"
         :recursive t
	 :exclude "html"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" 
         :components ("note-org" "note-static")
         :author "yizhang84@gmail.com"
         )))
;; paredit mode
; (autoload 'paredit-mode "paredit" "Minor mode for paredit" t)

;; lisp and slime
(setq inferior-lisp-program "/usr/local/bin/ccl64")
(require 'slime)
(require 'slime-autoloads)
(slime-setup '(slime-fancy))
(add-hook 'lisp-mode-hook (lambda ()
			    (slime-mode t)
			    (paredit-mode +1)
			    (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

;; haskell-mode
; (load "~/.emacs.d/haskell-mode/haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; my convenient functions

(defun move-line-up ()
  "Moves the current line down, like textmate does"
  (interactive)
  ;; (progn (kill-whole-line)
  ;; 	 (forward-line direction)
  ;; 	 (yank)
  ;; 	 (forward-line direction)))
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (next-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key [M-up] 'move-line-up)
(global-set-key [M-down] 'move-line-down)

(when (require 'rainbow-delimiters nil 'noerror)
  (progn
	(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
	(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)))

;; for python
(setq python-shell-virtualenv-path "~/.virtualenvs/default")
; (load-file "~/.emacs.d/emacs-for-python/epy-init.el")
; (require 'epy-setup)
; (require 'epy-python)
; (require 'epy-editing)
; (epy-setup-ipython)
;;(global-hl-line-mode t)
; (require 'pymacs)
; (pymacs-load "ropemacs" "rope-")
; (setq ropemacs-enable-autoimport t)

;; (add-to-list 'auto-mode-alist '("\\.py$\\'" . python-mode))
;; (autoload 'python-mode "python-mode" "Python Mode." t) 
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
(defun my-python-setup ()
  nil)
(add-hook 'python-mode-hook 'my-python-setup)

;; (add-to-list 'load-path "~/.emacs.d/pymacs")
;; (add-to-list 'load-path "~/.emacs.d/ropemacs")
;(require 'ipython)
;(setq py-python-command-args '("--colors" "Linux"))
;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args ""
;;       python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;       python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;       python-shell-completion-setup-code ""
;;       python-shell-completion-string-code
;;       "';'.join(__IP.complete('''%s'''))\n")

(defun my-setup-frame (&rest frame)
  (if (display-graphic-p)
     (progn
	     (tool-bar-mode -1))))
(add-hook 'after-make-frame-functions 'my-setup-frame t)

(setq ibuffer-saved-filter-groups
      '(("default"
	 ("org" (mode . org-mode))
	 ("riotfusion" (filename . "riotfusion/"))
	 ("code" (or
		  (mode . c-mode)
		  (mode . c++-mode)
		  (mode . python-mode)
		  (mode . emacs-lisp-mode))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))

; (require 'anything-match-plugin)
; (require 'anything-config)
; (global-set-key (kbd "C-x b")
;   (lambda() (interactive)
;     (anything
;      :prompt "Switch to: "
;      :candidate-number-limit 10                 ;; up to 10 of each 
;      :sources
;      '( anything-c-source-buffers               ;; buffers 
;         anything-c-source-recentf               ;; recent files 
;         anything-c-source-bookmarks             ;; bookmarks
;         anything-c-source-files-in-current-dir+ ;; current dir
;         anything-c-source-locate))))            ;; use 'locate'

(defun select-current-line ()
  "select the current line"
  (interactive)
  (end-of-line)
  (set-mark (line-beginning-position)))
(global-set-key (kbd "C-S-l") 'select-current-line)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'deft)
(setq deft-extension "org")
(setq deft-text-mode 'org-mode)
(global-set-key [f5] 'deft)

;; like f in vim
(require 'iy-go-to-char)
(global-set-key (kbd "M-n") 'iy-go-to-char)
(global-set-key (kbd "C-c F") 'iy-go-to-char-backward)
(global-set-key (kbd "C-c ;") 'iy-go-to-char-continue)
(global-set-key (kbd "C-c ,") 'iy-go-to-char-continue-backward)

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "fj" 'iy-go-to-char)
(key-chord-define-global "df" 'iy-go-to-char-backward)

;; emulate cmd-enter in textmate
(defun newline-below()
  "add a new line below and jump there"
  (interactive)
  (end-of-line)
  (newline-and-indent))

(global-set-key (kbd "C-<return>") 'newline-below)

;; (require 'saveplace)
;; (setq-default save-palce t)

(which-func-mode t)

;; highlight TODO and alike
(defun highlight-todo ()
  (font-lock-add-keywords nil
			  '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t))))
(add-hook 'c-mode-common-hook
	  'highlight-todo)
(add-hook 'python-mode-hook
	  'highlight-todo)

(add-to-list 'load-path "~/.emacs.d/expand-region")
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)

(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)

(setq multi-term-program "/bin/zsh") ;; or use zsh...

;; only needed if you use autopair
(add-hook 'term-mode-hook
  #'(lambda () (setq autopair-dont-activate t)))

(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term) ;; create a new one

(setq recent-jump-threshold 4)
(setq recent-jump-ring-length 10)
(global-set-key (kbd "C-o") 'recent-jump-jump-backward)
(global-set-key (kbd "M-o") 'recent-jump-jump-forward)
(require 'recent-jump)