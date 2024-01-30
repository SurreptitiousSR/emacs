(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-bullets toc-org which-key general evil-collection evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Run evil mode on startup with configuration options
(use-package evil
    :init
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right t)
    (evil-mode))
  (use-package evil-collection
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))

;; Adds the MELPA repositories 
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Changes Meta key to "Command" instead of "Alt"
(setq mac-option-key-is-meta nil
mac-command-key-is-meta t
mac-command-modifier 'meta
mac-option-modifier 'none)

;; General keybindings 
(use-package general
    :config
    (general-evil-setup)

    ;; set up 'SPC' as the global leader key
    (general-create-definer chronicler/leader-keys
	:states '(normal insert visual emacs)
	:keymaps 'override
	:prefix "SPC" ;; set leader
	:global-prefix "M-SPC") ;; access leader in insert mode

    (chronicler/leader-keys
      "b" '(:ignore t :wk "buffer") ;; :wk = which key 
      "bb" '(switch-to-buffer :wk "Switch buffer")
      "bi" '(ibuffer :wk "Ibuffer")
      "bk" '(kill-this-buffer :wk "Kill this buffer")
      "bn" '(next-buffer :wk "Next buffer")
      "bp" '(previous-buffer :wk "Previous buffer")
      "br" '(revert-buffer :wk "Reload buffer")
     )

    (chronicler/leader-keys
      "e" '(:ignore t :wk "Evaluate")
      "eb" '(eval-buffer :wk "Evaluate elisp in buffer")
      "ed" '(eval-defun :wk "Evaluate defun containing or after point")
      "ee" '(eval-expression :wk "Evaluate and elisp expression")
      "el" '(eval-last-sexp :wk "Evaluate elisp expression before point")
      "er" '(eval-region :wk "Evaluate elisp in region"))

    (chronicler/leader-keys
"f" '(:ignore t :wk "Find")
      "." '(find-file :wk "Find file")
      "fc" '((lambda () (interactive) (find-file "~/.emacs.d/config.org")) :wk "Edit emacs config")
"fr" '(counsel-recentf :wk "Find recent files"))


    (chronicler/leader-keys
      "h" '(:ignore t :wk "Help")
      "hf" '(describe-function :wk "Describe function")
      "hv" '(describe-variable :wk "Describe variable")
      "hrr" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :wk "Reload emacs config"))

    (chronicler/leader-keys
      "t" '(:ignore t :wk "Toggle")
      "tl" '(display-line-numbers-mode :wk "Toggle line numbers")
      "tt" '(visual-line-mode :wk "Toggle truncated lines"))

    (chronicler/leader-keys
      "s" '(:ignore t :wk "Shell")
      "ss" '(shell :wk "Open shell")))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

;; Default fonts
(set-face-attribute 'default nil
		    :font "Ac437 IBM Conv 11"
		    :height 110
		    :weight 'medium)

(set-face-attribute 'variable-pitch nil
		    :font "Bell Centennial Std"
		    :height 120
		    :weight 'medium)

(set-face-attribute 'fixed-pitch nil
		    :font "Ac437 IBM Conv 11"
		    :height 110
		    :weight 'medium)


;; Makes commented text italic
(set-face-attribute 'font-lock-comment-face nil
		    :slant 'italic)

;; Change default line spacing
(setq-default line-spacing 0.40)

;; Change the foreground, background, and cursor colours
(add-to-list 'default-frame-alist '(foreground-color . "white"))
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(cursor-color . "green"))

(scroll-bar-mode -1) ;; remove the scroll bar

(tool-bar-mode -1) ;; remove the tool bar (bar at top of screen)

;; Display line numbers and truncated lines
(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

;; Which key configuration
(use-package which-key
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit t
	  which-key-separator " → " ))

;; Turn on ORG tempo at startup
(require 'org-tempo)

;; ORG mode table of contents
(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

;; ORG mode bullets
(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Turn off ORG mode annoying automatic indent
(electric-indent-mode -1)
