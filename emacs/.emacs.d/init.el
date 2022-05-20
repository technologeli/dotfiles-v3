(defvar eli/default-font-size 120)
(defvar eli/default-variable-font-size 140)
(defvar eli/frame-transparency '(90 . 90))
(defvar eli/default-font "FiraCode Nerd Font")
(defvar eli/default-variable-font "Ubuntu")

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Non-Linux
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
;; ensures packages are always downloaded
(setq use-package-always-ensure t)

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; Prevent customization variables to be put here
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(setq use-dialog-box nil)
(column-number-mode)
(set-fringe-mode 10)
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package doom-themes
  :config
  (load-theme 'doom-tomorrow-night t)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; run M-x all-the-icons-install-fonts
(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 40)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(set-face-attribute 'default nil :font eli/default-font :height eli/default-font-size)
(set-face-attribute 'fixed-pitch nil :font eli/default-font :height eli/default-font-size)

(set-face-attribute 'variable-pitch nil :font eli/default-variable-font :height eli/default-variable-font-size :weight 'regular)

(recentf-mode 1)
(setq history-length 10)
(savehist-mode 1)
(save-place-mode 1)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(use-package undo-tree
  :diminish undo-tree-mode
  :defer t
  :init (setq undo-tree-auto-save-history nil))
(global-undo-tree-mode 1)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "<mouse-9>") 'evil-jump-forward)
(global-set-key (kbd "<mouse-8>") 'evil-jump-backward)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

;; Evil Collection provides bindings for various community modes.
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package general
  :after evil
  :config
  (general-evil-setup t)
  (general-create-definer eli/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (eli/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tc" '(counsel-load-theme :which-key "choose theme")
    "b"  '(counsel-ibuffer :which-key "buffer")
    "r"  '(counsel-recentf :which-key "recent files")))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.2))

;; Ivy, Swiper, and Counsel are designed to work well together.
;; Counsel depends on Ivy and Swiper, but Ivy has some extra configuration.
(use-package ivy
  :diminish ;; Hides ivy-mode in the list of modes in the modeline
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

;; Provides context within the minibuffer
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

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

;; C-c p f projectile-find-file
;; C-c p s r counsel-projectile-rg (use C-c o to move this into a buffer)
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map))
  ;; NOTE: Set this to the folder where you keep your Git repos!
  ;; :init
  ;; (when (file-directory-p "~/Projects/Code")
  ;;   (setq projectile-project-search-path '("~/Projects/Code")))
  ;; (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
(eli/leader-keys
  "g" '(magit-status :which-key "magit"))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

;; Tangle config.org when we save it
(defun eli/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/dotfiles-v3/emacs/.emacs.d/config.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'eli/org-babel-tangle-config)))

(defun eli/org-mode-setup()
  (org-indent-mode)
  (visual-line-mode 1))

(defun eli/org-font-setup ()
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))

(use-package org
  :hook (org-mode . eli/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-hide-emphasis-markers t)

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
	'("" ""))
  (eli/org-font-setup))

(eli/leader-keys
  "o"  '(:ignore o :which-key "org")
  "ot" '(org-todo :which-key "org-todo")
  "oi" '(org-time-stamp :which-key "org-time-stamp")
  "og" '(counsel-org-tag :which-key "counsel-org-tag")
  "oa" '(org-agenda :which-key "org-agenda")
  "os" '(org-schedule :which-key "org-schedule"))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun eli/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . eli/org-mode-visual-fill))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (setq lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(eli/leader-keys
  "tt" '(treemacs :which-key "filetree")
  "lo" '(lsp-organize-imports :which-key "organize imports")
  "lR" '(lsp-treemacs-references :which-key "find references")
  "lr" '(lsp-rename :which-key "rename")
  "ld" '(lsp-find-definition :which-key "find definition")
  "lf" '(lsp-ivy-global-workspace-symbol :which-key "find symbol"))

;; Better completions
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind
  (:map company-active-map
	("<tab>" . company-complete-section))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package python-mode
  :hook (python-mode . lsp-deferred))

(+ 2 4)
