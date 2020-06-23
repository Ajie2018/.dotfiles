(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (org-bullets which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;user stuff
(setq inhibit-startup-message t)    ;;shut off welcome windows
(scroll-bar-mode -1)   ;;turn off scrollbar
(tool-bar-mode -1)   ;;turn off scrollbar
(menu-bar-mode -1)   ;;turn off scrollbar

(use-package try
  :ensure t)
(use-package which-key
  :ensure t
  :config (which-key-mode))
;;org stuff
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(global-linum-mode t)    ;;display line number
;;(global-company-mode t)    ;;open autocompletion
(global-hl-line-mode)

(defun open-my-init-file()    ;;define a function to open my configuration
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-my-init-file)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 20)
(global-set-key "\C-x\C-r" 'recentf-open-files)

(setq init-frame-alist (quote((fulscreen.maxumized))))
(add-hook 'emacs-lisp-hook 'show-parent-mode)

