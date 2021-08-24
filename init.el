;;; Package -- init
;;; Commentary:
;;; Code:

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
																				;(setq user-emacs-directory "~/.cache/emacs")

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(setq indent-tabs-mode nil)

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
;; (setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Set frame transparency

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defun myconfig/set-font-face ()
	"This is somewhat documentation."
	(defvar myconfig/frame-transparency '(100 . 100))
	(defvar myconfig/default-font-size 100)
	(defvar myconfig/default-variable-font-size 100)

	(set-frame-parameter (selected-frame) 'alpha myconfig/frame-transparency)
	(add-to-list 'default-frame-alist `(alpha . ,myconfig/frame-transparency))

	(set-face-attribute 'default nil :font "Jetbrains Mono" :height myconfig/default-font-size)
	(set-face-attribute 'fixed-pitch nil :font "Jetbrains Mono" :height myconfig/default-font-size)
	(set-face-attribute 'variable-pitch nil :font "Cantarell" :height myconfig/default-variable-font-size :weight 'regular))


(if (daemonp)
		(add-hook 'after-make-frame-functions
							(lambda (frame)
								;; (setq doom-modeline-icon t)
								(with-selected-frame frame
									(myconfig/set-font-face))))
	(myconfig/set-font-face))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(defun myconfig/edit-config ()
	"This command is for editing Emacs config."
	(interactive)
	(find-file-at-point "~/.emacs.d/init.el"))

(defun myconfig/edit-awesome-config ()
	"This command is for editing AwesomeWM config."
	(interactive)
	(find-file-at-point "~/.config/awesome/rc.lua"))

(use-package general
  :after evil
  :config
  (general-create-definer myconfig/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (myconfig/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "th" '(load-theme :which-key "choose theme")

    "s"   '(swiper :which-key "Swiper")

    "SPC" '(counsel-M-x :which-key "M-x")

		"l"   '(:ignore t :which-key "LSP")
		"lr"  '(lsp-ui-peek-find-references :which-key "References")

		"lR"  '(:ignore t :which-key "Rename")
		"lRr" '(lsp-rename :which-key "Selected")
		"lRf" '(lsp-rename-file :which-key "File")
		"lRp" '(lsp-rename-params :which-key "Parameters")

		"li"  '(lsp-find-implementation :which-key "Implementation")
		"lf"  '(lsp-format-buffer :which-key "Format Buffer")
		"ld"  '(lsp-find-definition :which-key "Definition")
		"la"  '(lsp-execute-code-action :which-key "Code Action")

		"k"  '(kill-current-buffer :which-key "Kill Buffer")
		"K"  '(kill-buffer-and-window :which-key "Buffer and window")

		"p"  '(projectile-command-map :which-key "Projectile")

    "w"  '(:ignore t :which-key "Window")
    "ww" '(delete-other-windows :which-key "Delete Other")
    "wo" '(other-window :which-key "Next Window")
		"wq" '(delete-window :which-key "Delete Window")
		"w+" '(balance-windows :which-key "Balance Windows")
		"w_" '(evil-window-set-height :which-key "Set Window Height")
		"w|" '(evil-window-set-width :which-key "Set Window Width")
		"wf" '(find-file-other-window :which-key "Find File Other Window")
		"wd" '(dired-other-window :which-key "Dired Other Window")
		"wj" '(dired-jump-other-window :which-key "Dired Jump Other Window")
		"wb" '(counsel-switch-buffer-other-window :which-key "Buffers Other Window")

		"e"  '(:ignore t :which-key "Eval")
		"es" '(eval-last-sexp :which-key "Last Sexp")
		"eb" '(eval-buffer :which-key "Buffer")
		"er" '(eval-region :which-key "Region")
		"ed" '(eval-defun :which-key "Defun")
		"ee" '(eval-expression :which-key "Expression")

		"o"  '(:ignore t :which-key "Open")
		"oe" '(eshell    :which-key "Eshell")
		"od" '(dired     :which-key "Dired")
		"oc" '(calendar  :which-key "Calendar")
		"op" '(org-timer-set-timer :which-key "Pomodoro")

		"["  '(:ignore t :which-key "Smartparens")
		"[(" '(sp-wrap-round :which-key "()")
		"[{" '(sp-wrap-curly :which-key "{}")
		"[[" '(sp-wrap-square :which-key "[]")
		"[d" '(sp-splice-sexp :which-key "Splice Sexp")
		"[\"" '(sp-wrap)
		"[r" '(sp-rewrap-sexp :which-key "Rewrap Sexp")
		"[s" '(sp-forward-slurp-sexp :which-key "Forward Slurp")
		"[S" '(sp-backward-slurp-sexp :which-key "Backward Slurp")
		"[b" '(sp-forward-barf-sexp :which-key "Forward Barf")
		"[B" '(sp-backward-barf-sexp :which-key "Backward Barf")
		"[h" '(sp-forward-slurp-hybrid-sexp :which-key "Hybrid S Forward")
		"[H" '(sp-backward-slurp-hybrid-sexp :which-key "Hybrid S Forward")

		"b"  '(counsel-switch-buffer :which-key "Buffers")

		"f"   '(:ignore t :which-key "File")
		"ff"  '(find-file :which-key "Find Files")
		"fc"  '(:ignore t :which-key "ConfigFiles")
    "fce" '(myconfig/edit-emacs-config :which-key "Emacs")
    "fca" '(myconfig/edit-awesome-config :which-key "Awesome")))

(defun myconfig/org-pomodoro ()
	"This is for pomodoro."
	(require 'org)
	(setq org-clock-sound "~/.emacs.d/sounds/pomo-timesup.wav"))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package command-log-mode
  :commands command-log-mode)

(use-package doom-themes
  :init (load-theme 'doom-one t))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 18)))

(use-package which-key

  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
																				;(prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(myconfig/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(defun myconfig/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.5)
                  (org-level-2 . 1.35)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.05)
                  (org-level-5 . 1.0)
                  (org-level-6 . 0.90)
                  (org-level-7 . 0.8)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun myconfig/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . myconfig/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/codes/orgs/task.org"
          "~/codes/orgs/habits.org"
          "~/codes/orgs/birthdays.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
				'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
					(sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
				'(("Archive.org" :maxlevel . 1)
					("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
				'((:startgroup)
																				; Put mutually exclusive tags here
					(:endgroup)
					("@errand" . ?E)
					("@home" . ?H)
					("@work" . ?W)
					("agenda" . ?a)
					("planning" . ?p)
					("publish" . ?P)
					("batch" . ?b)
					("note" . ?n)
					("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
				'(("d" "Dashboard"
					 ((agenda "" ((org-deadline-warning-days 7)))
						(todo "NEXT"
									((org-agenda-overriding-header "Next Tasks")))
						(tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

					("n" "Next Tasks"
					 ((todo "NEXT"
									((org-agenda-overriding-header "Next Tasks")))))

					("W" "Work Tasks" tags-todo "+work-email")

					;; Low-effort next actions
					("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
					 ((org-agenda-overriding-header "Low Effort Tasks")
						(org-agenda-max-todos 20)
						(org-agenda-files org-agenda-files)))

					("w" "Workflow Status"
					 ((todo "WAIT"
									((org-agenda-overriding-header "Waiting on External")
									 (org-agenda-files org-agenda-files)))
						(todo "REVIEW"
									((org-agenda-overriding-header "In Review")
									 (org-agenda-files org-agenda-files)))
						(todo "PLAN"
									((org-agenda-overriding-header "In Planning")
									 (org-agenda-todo-list-sublevels nil)
									 (org-agenda-files org-agenda-files)))
						(todo "BACKLOG"
									((org-agenda-overriding-header "Project Backlog")
									 (org-agenda-todo-list-sublevels nil)
									 (org-agenda-files org-agenda-files)))
						(todo "READY"
									((org-agenda-overriding-header "Ready for Work")
									 (org-agenda-files org-agenda-files)))
						(todo "ACTIVE"
									((org-agenda-overriding-header "Active Projects")
									 (org-agenda-files org-agenda-files)))
						(todo "COMPLETED"
									((org-agenda-overriding-header "Completed Projects")
									 (org-agenda-files org-agenda-files)))
						(todo "CANC"
									((org-agenda-overriding-header "Cancelled Projects")
									 (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
				`(("t" "Tasks / Projects")
					("tt" "Task" entry (file+olp "~/Projects/Code/emacs-from-scratch/OrgFiles/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

					("j" "Journal Entries")
					("jj" "Journal" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
					("jm" "Meeting" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

					("w" "Workflows")
					("we" "Checking Email" entry (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

					("m" "Metrics Capture")
					("mw" "Weight" table-line (file+headline "~/Projects/Code/emacs-from-scratch/OrgFiles/Metrics.org" "Weight")
					 "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  (myconfig/org-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun myconfig/org-mode-visual-fill ()
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . myconfig/org-mode-visual-fill))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)))
  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("hs" . "src haskell"))
  (add-to-list 'org-structure-template-alist '("cp" . "src c"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

;; Automatically tangle our Emacs.org config file when we save it
(defun myconfig/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'myconfig/org-babel-tangle-config)))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge
  :after magit)

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "sh") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  (setq vterm-shell "bash")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "powershell.exe")
  (setq explicit-powershell.exe-args '()))

(defun myconfig/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . myconfig/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
		"q" 'kill-current-buffer
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :commands (dired dired-jump))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :commands (dired dired-jump)
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
	:config
  (setq-default flycheck-disabled-checkers
    (append flycheck-disabled-checkers
						'(javascript-jshint json-jsonlist)))
	(flycheck-add-mode 'javascript-eslint 'web-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; (setq display-line-numbers-type 'relative)

(setq-default tab-width 2)

(global-set-key (kbd "C-M-j") 'switch-to-next-buffer)
(global-set-key (kbd "C-M-k") 'switch-to-prev-buffer)

(global-set-key (kbd "C-M-+") 'text-scale-increase)
(global-set-key (kbd "C-M-_") 'text-scale-decrease)

(use-package company
	:ensure t
	:custom
	(company-minimum-prefix-length 1)
	(comapny-idle-delay 0.0))

(use-package company-box
	:ensure t
	:hook (company-mode . company-box-mode))

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook #'myconfig/org-pomodoro)

(yas-global-mode 1)

(use-package cider
	:ensure t)

;;; Projectile

(use-package projectile
	:diminish projectile-mode
	:config (projectile-mode)
	:init
	(when (file-directory-p "~/codes/")
		(setq projectile-project-search-path '("~/codes/clojure/" "~/codes/c/" "~/codes/rust/" "~/codes/flutter/" "~/codes/rust/" "~/codes/go/" "~/codes/web/" "~/codes/go/" "~/codes/haskell/" "~/codes/java/")))
	(setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
	:config (counsel-projectile-mode))

(use-package smartparens
	:ensure t
	:hook (prog-mode . smartparens-mode))
(put 'upcase-region 'disabled nil)

(use-package lsp-mode
	:commands (lsp lsp-deferred)
	:init
	(setq lsp-keymap-prefix "C-c l")
	:config
	(lsp-enable-which-key-integration t))

(use-package lsp-ui
	:hook (lsp-mode . lsp-ui-mode))

(use-package lsp-ivy)

(use-package treemacs
	:after lsp)

(use-package rjsx-mode
	:mode "\\.js[x]?\\'"
	:hook (rjsx-mode . lsp-deferred)
	:config
	(setq js-indent-level 2)
	(setq lsp-headerline-breadcrumb-icons-enable nil))

(use-package typescript-mode
	:mode "\\.ts[x]?\\'"
	:hook (typescript-mode . lsp-deferred)
	:config
	(setq typescript-indent-level 2)
	(setq lsp-headerline-breadcrumb-icons-enable nil))

(use-package haskell-mode
	:ensure t
	:hook (haskell-mode . lsp-deferred)
	:config
	(setq lsp-headerline-breadcrumb-icons-enable nil))

(use-package lsp-haskell
	:ensure t)

;; (defun myconfig/go-mode-hook ()
;;   "Call Gofmt before saving."
;; 	(setq gofmt-command "goimports")
;;   (add-hook 'before-save-hook 'gofmt-before-save)
;;   (if (not (string-match "go" compile-command))
;;       (set (make-local-variable 'compile-command)
;;            "go build -v && go test -v && go vet")) ; Godef jump key binding
;;   (myconfig/leader-keys
;;     "g"  '(:ignore t :which-key "Goto")
;;     "gd" '(godef-jump :which-key "Definition")
;; 	  "gb" '(godef-describe :which-key "Def Describe")
;; 		"ga" '(go-goto-arguments :which-key "Arguments")
;; 		"gt" '(go-goto-return-values :whch-key "Return Values")
;; 		"gr" '(go-goto-method-receiver :which-key "Receiver")))

;; (add-hook 'go-mode-hook 'myconfig/go-mode-hook)
(use-package go-mode
  :hook (go-mode . lsp-deferred)
	:config
	(setq lsp-headerline-breadcrumb-icons-enable t))

(add-hook 'c-mode-hook #'lsp-deferred)

;; System cleaning
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves-sessions" user-emacs-directory)
			auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

(setq create-lockfiles nil)

;; Shell switcher
(use-package shell-switcher
	:config
	(myconfig/leader-keys
		"t"  '(:ignore t :which-key "Shell Switcher")
		"tw" '(shell-switcher-switch-buffer-other-window :which-key "Other window shell")
		"tt" '(shell-switcher-switch-buffer :which-key "Switch to other")
		"tn" '(shell-switcher-new-shell :which-key "New eshell")
		"tK" '(shell-switcher-kill-all-shells :which-key "Kill all shell")))

(setq shell-switcher-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	 '(c-mode lsp-haskell haskell-mode rjsx-mode lsp-ui company-box counsel-projectile projectile cider yasnippet which-key vterm visual-fill-column use-package smartparens rainbow-delimiters org-bullets ivy-rich ivy-prescient hydra helpful go-mode general format-all forge flycheck evil-nerd-commenter evil-collection eterm-256color eshell-git-prompt doom-themes doom-modeline dired-single dired-open dired-hide-dotfiles counsel company command-log-mode auto-package-update all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; (provide 'init)
;;; init.el ends here
