(defvar eli/default-font-size 130)
(defvar eli/default-variable-font-size 130)
(defvar eli/frame-transparency '(90 . 90))
(defvar eli/default-font "FiraCode Nerd Font")
(defvar eli/default-variable-font "Fira Sans Book")

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
;; (setq use-package-verbose t)

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
  (load-theme 'doom-gruvbox t)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; run M-x all-the-icons-install-fonts
(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 35)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package beacon
  :custom (beacon-blink-duration 0.2)
  :config
  (beacon-mode 1))

(defun eli/set-font-faces ()
  ;; ??????!
  (set-fontset-font "fontset-default" 'hangul "Noto Sans CJK KR Regular")
  (set-face-attribute 'default nil :font eli/default-font :height eli/default-font-size)
  (set-face-attribute 'fixed-pitch nil :font eli/default-font :height eli/default-font-size)

  (set-face-attribute 'variable-pitch nil :font eli/default-variable-font :height eli/default-variable-font-size :weight 'regular))

(if (daemonp)
  (add-hook 'after-make-frame-functions
    (lambda (frame)
      (setq doom-modeline-icon t)
      (with-selected-frame frame
      (eli/set-font-faces))))
  (eli/set-font-faces))

(setq org-format-latex-options '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
           ("begin" "$1" "$" "$$" "\\(" "\\[")))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome, Eli.")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-footer nil)
  (setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  (setq dashboard-item-names '(("Agenda for the coming week:" . "Agenda:")))
  (setq dashboard-center-content t)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (agenda . 5))))

(defun eli/goto-dashboard ()
  (interactive)
  (switch-to-buffer "*dashboard*"))

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
    "h"  '(eli/goto-dashboard :which-key "homepage")
    "c"  '(flyspell-correct-word-before-point :which-key "correct word")
    "v"  '(vterm :which-key "vterm")
    "t"  '(:ignore t :which-key "toggles")
    "tc" '(counsel-load-theme :which-key "choose theme")
    "tl" '(org-latex-preview :which-key "toggle latex preview")
    "b"  '(counsel-ibuffer :which-key "buffer")
    "H"  '(previous-buffer :which-key "previous-buffer")
    "L"  '(next-buffer :which-key "next-buffer")
    "w"  '(:ignore w :which-key "window")
    "wh"  '(evil-window-left :which-key "window-left")
    "wj"  '(evil-window-down :which-key "window-down")
    "wk"  '(evil-window-up :which-key "window-up")
    "wl"  '(evil-window-right :which-key "window-right")
    "wv"  '(evil-window-vsplit :which-key "window-vsplit")
    "wf"  '(delete-other-windows :which-key "window-fullscreen")
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
(eli/leader-keys
  "p" '(:keymap projectile-command-map :package projectile :which-key "projectile"))

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

(defun eli/org-font-setup ()
  ;; (font-lock-add-keywords 'org-mode
  ;;                         '(("^ *\\([-]\\) "
  ;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "???"))))))
;; Set faces for heading levels
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.0)
                (org-level-4 . 1.0)
                (org-level-5 . 1.0)
                (org-level-6 . 1.0)
                (org-level-7 . 1.0)
                (org-level-8 . 1.0)))
  (set-face-attribute (car face) nil :font eli/default-variable-font :weight 'regular :height (cdr face)))

;; Ensure that anything that should be fixed-pitch in Org files appears that way
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
)

(defun eli/org-mode-setup()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (eli/org-font-setup)
)

(defvar eli/org-agenda-files '("~/wikeli/20220521061448-agenda.org"
                               "~/wikeli/20220521082425-archive.org"))

(use-package org
  :commands (org-capture org-agenda)
  :hook (org-mode . eli/org-mode-setup)
  :config
  (setq org-ellipsis " ???")
  (setq org-hide-emphasis-markers t)

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files eli/org-agenda-files)

  (setq org-refile-targets
    '(("~/wikeli/20220521082425-archive.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
     '((:startgroup)
        ;; mutually exclusive tags
       (:endgroup)
       ("project" . ?p)
       ))

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "IDEA(i)" "|" "DONE(d!)")))

  (setq org-agenda-custom-commands
    '(("d" "Dashboard"
       ((agenda "" ((org-deadline-warning-days 14)))
         (todo "NEXT"
           ((org-agenda-overriding-header "Next Tasks")))))))

  (setq org-capture-templates
    `(("t" "Task" entry (file+olp "~/wikeli/20220521061448-agenda.org" "Inbox")
            "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
      ("p" "Phrase" entry (file+olp "~/wikeli/20220523112202-words_and_phrases.org" "Unsorted") "* %?" :empty-lines 1)))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60))

(eli/leader-keys
  "o"  '(:ignore o :which-key "org")
  "oa" '(org-agenda :which-key "org-agenda")
  "oc" '(org-ctrl-c-ctrl-c :which-key "c c")
  "od" '(org-deadline :which-key "org-deadline")
  "og" '(counsel-org-tag :which-key "counsel-org-tag")
  "oi" '(org-time-stamp :which-key "org-time-stamp")
  "ol" '(org-insert-link :which-key "org-insert-link")
  "oo" '(org-capture :which-key "org-capture")
  "op" '(org-set-property :which-key "org-set-property")
  "or" '(org-refile :which-key "org-refile")
  "os" '(org-schedule :which-key "org-schedule")
  "ot" '(org-todo :which-key "org-todo"))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("???" "???" "???" "???" "???" "???" "???")))

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

(defun eli/org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun eli/org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (eli/org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))

(use-package org-roam
  :commands (org-capture org-agenda)
  :custom
  (org-roam-directory "~/wikeli")
  (org-roam-completion-everywhere t)
  :config
  (message "Loading Roam")
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode)

  (setq org-agenda-files
    (append eli/org-agenda-files
      (eli/org-roam-list-notes-by-tag "project")))

  (setq org-roam-node-display-template
    (concat "${title:40} "
      (propertize "${tags:*}" 'face 'org-tag)))

  (setq org-roam-dailies-directory "journal/")
  (setq org-link-frame-setup '((vm . vm-visit-folder-other-frame)
                               (vm.imap . vm-visit-imap-folder-other-frame)
                               (gnus . org-gnus-no-new-news)
                               (file . find-file)
                               (wl . wl-other-frame))))

(general-define-key :keymaps 'org-mode-map "C-M-i" 'completion-at-point)

(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(eli/leader-keys
  "r" '(:ignore r :which-key "org-roam")
  "rt" '(org-roam-buffer-toggle :which-key "buffer-toggle")
  "rf" '(org-roam-node-find :which-key "node-find")
  "ri" '(org-roam-node-insert :which-key "node-insert")
  "rI" '(org-roam-node-insert-immediate :which-key "node-insert-immediate")
  "ro" '(org-open-at-point :which-key "open-at-point")
  "rdY" '(org-roam-dailies-capture-yesterday :which-key "capture-yesterday")
  "rdT" '(org-roam-dailies-capture-tomorrow :which-key "capture-tomorrow")
  "rd" '(:keymap org-roam-dailies-map :package org-roam :which-key "dailies"))

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
