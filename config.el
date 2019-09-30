(setq inhibit-startup-message t)

(setq make-backup-file nil)
(setq auto-save-default nil)

(setq ring-bell-function 'ignore)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(package-initialize)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (line-number-mode 1)
(column-number-mode 1)
 (global-set-key(kbd "M-4") 'display-line-numbers-mode)
(add-hook 'org-mode-hook 'org-indent-mode)

(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

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

(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))

(use-package multiple-cursors
  :ensure t
  :bind ("C-c q" . 'mc/mark-next-like-this)
  :bind ("C-c v" . 'mc/skip-to-next-like-this))
(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(use-package exwm
  :ensure t
  :config
  (require 'exwm-config)
  (exwm-config-default))

(require 'exwm-systemtray)
(exwm-systemtray-enable)

(global-set-key (kbd "s-k") 'exwm-workspace-delete)
(global-set-key (kbd "s-w") 'exwm-workspace-swap)

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
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map(kbd "C-n") #'company-select-next)
  (define-key company-active-map(kbd "C-p") #'company-select-previous))

(use-package company-irony
  :ensure t
  :config(require 'company)
  (add-to-list 'company-backends 'company-irony))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )

(with-eval-after-load 'company(add-hook 'c++-mode-hook 'company-mode)
                      (add-hook 'c-mode-hook 'company-mode)
                      (add-hook 'java-mode-hook 'company-mode))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))
(display-battery-mode)

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
(setq sr-speedbar-right-side nil)

(use-package magit
  :ensure t)
