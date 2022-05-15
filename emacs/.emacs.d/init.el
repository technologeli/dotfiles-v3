;; Vars
(defvar efs/default-font-size 120)
(defvar efs/default-variable-font-size 120)
(defvar efs/frame-transparency '(90 . 90))

;; Package Management
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

;; UI and Theming
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

(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height efs/default-font-size)

(use-package doom-themes
  :config
  (load-theme 'doom-vibrant t)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; run M-x all-the-icons-install-fonts
(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 40)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Persistent History
(recentf-mode 1)
(setq history-length 10)
(savehist-mode 1)
(save-place-mode 1)

;; Prevent customization variables to be put here
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; refresh buffers
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; ESC quits prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package undo-tree
  :diminish undo-tree-mode
  :defer t
  :init (setq undo-tree-auto-save-history nil))
(global-undo-tree-mode 1)

;; Vim
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

;; Keybinds
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
    "tt" '(counsel-load-theme :which-key "choose theme")))

(global-set-key (kbd "<mouse-9>") 'evil-jump-forward)
(global-set-key (kbd "<mouse-8>") 'evil-jump-backward)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

;; Completion
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

;; Project Management
;; Cool commands:
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

;; Git
(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
