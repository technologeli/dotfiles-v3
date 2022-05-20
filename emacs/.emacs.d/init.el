(defvar eli/default-font-size 140)
(defvar eli/default-variable-font-size 140)
(defvar eli/frame-transparency '(90 . 90))
(defvar eli/default-font "FiraCode Nerd Font")
(defvar eli/default-variable-font "Ubuntu")

(setq gc-cons-threshold (* 50 1000 1000))

(defun eli/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'eli/display-startup-time)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
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

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

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
(dolist (mode '(org-mode-hook
                term-mode-hook
                vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package doom-themes
  :config
  (load-theme 'doom-one t)

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

(setq org-format-latex-options '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
           ("begin" "$1" "$" "$$" "\\(" "\\[")))

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
    "tl" '(org-latex-preview :which-key "toggle latex preview")
    "b"  '(counsel-ibuffer :which-key "buffer")
    "R"  '(counsel-recentf :which-key "recent files")))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
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
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1))

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

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

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
  ;; (setq projectile-switch-project-action #'projectile-dired)

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
(eli/leader-keys
  "g" '(magit-status :which-key "magit"))

(with-eval-after-load 'org
  (org-babel-do-load-languages
    'org-babel-load-languages
    '((emacs-lisp . t)
      (python . t))))

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
  :commands (org-capture org-agenda)
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

(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

(use-package org-roam
  :custom
  (org-roam-directory "~/wikeli")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup)
  (setq org-link-frame-setup '((vm . vm-visit-folder-other-frame)
                              (vm.imap . vm-visit-imap-folder-other-frame)
                              (gnus . org-gnus-no-new-news)
                              (file . find-file)
                              (wl . wl-other-frame))))

(eli/leader-keys
  "r" '(:ignore r :which-key "org-roam")
  "rh" '(org-mark-ring-goto :which-key "buffer-toggle")
  "rl" '(org-mark-ring-goto -1 :which-key "buffer-toggle")
  "rt" '(org-roam-buffer-toggle :which-key "buffer-toggle")
  "rf" '(org-roam-node-find :which-key "node-find")
  "ri" '(org-roam-node-insert :which-key "node-insert"))

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

(use-package lsp-ivy
  :after lsp)

(eli/leader-keys
  "tt" '(treemacs :which-key "filetree")
  "lo" '(lsp-organize-imports :which-key "organize imports")
  "lR" '(lsp-treemacs-references :which-key "find references")
  "lr" '(lsp-rename :which-key "rename")
  "ld" '(lsp-find-definition :which-key "find definition")
  "lf" '(lsp-ivy-global-workspace-symbol :which-key "find symbol"))

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

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "fish")
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "/bin/fish")
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  (setq vterm-max-scrollback 10000))

(use-package dired
  :ensure nil
  :hook (dired-mode . dired-hide-details-mode)
  :commands (dired dired-jump)
  :custom
  ((dired-listing-switches "-laD --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
     "h" 'dired-single-up-directory
     "l" 'dired-single-buffer))
(eli/leader-keys
  "d" '(dired :which-key "dired"))

(use-package dired-single
  :after dired)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

(setq gc-cons-threshold (* 2 1000 1000))
