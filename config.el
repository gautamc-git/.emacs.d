(setq inhibit-startup-message t)

(setq make-backup-file nil)
(setq auto-save-default nil)

(setq ring-bell-function 'ignore)

(prefer-coding-system 'utf-8)
  (package-initialize)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (line-number-mode 1)
(column-number-mode 1)

(global-subword-mode 1)

(setq electric-pair-pairs '(
			    (?\( . ?\))
			    (?\[ . ?\])
			    (?\{ . ?\})

			    ))
(electric-pair-mode t)

(use-package sudo-edit
:ensure t
:bind("C-M-1" . sudo-edit) )

(setq display-time-24hr-format t)
(display-time-mode 1)

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t)

  )

;;install use-package if it doesnt exist
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

;;download and install alect themes

(unless (package-installed-p 'alect-themes)
  (package-refresh-contents)
  (package-install 'alect-themes))

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(defalias 'yes-or-no-p 'y-or-n-p)

;;enable which-key and use which-key mode 
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package dashboard
:ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10))))

(defvar term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list term-shell)))
(ad-activate 'ansi-term)

(global-set-key(kbd "M-2") 'ansi-term)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(setq org-src-window-setup 'current-window)

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-vertical-mode
    :ensure t
    :init
    (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(use-package smex
  :ensure t
  :init
  (smex-initialize)
  :bind
  ("M-x" . smex))

(global-set-key (kbd "C-x b") 'ibuffer)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(setq ibuffer-expert t)

(defun kill-curr-buffer()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-curr-buffer)

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

(defun kill-whole-word()
  (interactive)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w w") 'kill-whole-word)

(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

(defun copy-whole-line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'copy-whole-line)

(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-M-k") 'kill-all-buffers)

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))

(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(use-package switch-window 
  :ensure t
  :config
  (setq switch-window-input-style 'minibuffer)
  (setq switch-window-increase 4)
  (setq switch-window-threshold 2)
  (setq switch-window-shortcut-style 'qwerty)
  (setq switch-window-qwerty-shortcuts
	'("a" "s" "d" "f" "j" "k" "l"))
  :bind
  ([remap other-window] . switch-window))

(defun split-and-follow-horizontally()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(use-package rainbow-mode
  :ensure t
  :init
  (rainbow-mode 1))

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))

(use-package diminish
     :ensure
     :init
     (diminish 'hungry-delete-mode)
     (diminish 'beacon-mode)
     (diminish 'which-key-mode)
     (diminish 'subword-mode)
     (diminish 'rainbow-mode))

(use-package smart-compile
  :ensure t
  )
(global-set-key (kbd "M-3") 'smart-compile)

(use-package sr-speedbar
  :ensure t)
(global-set-key (kbd "M-1") 'sr-speedbar-toggle)

(use-package magit
  :ensure t)
