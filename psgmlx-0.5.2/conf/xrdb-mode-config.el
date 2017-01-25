;;; xrdb-mode-config.el --- config file for the xrdb-mode package

;; $Id: xrdb-mode-config.el,v 1.1.1.1 2007/04/20 13:10:55 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.


;;; Commentary:

;; Note: The xrdb-mode package provides a major mode 
;;       for editing X resource files.  
;;       Author: Barry A. Warsaw
;;       Homepage: http://www.python.org/emacs/



;;; Code:



(autoload 'xrdb-mode "xrdb-mode" 
  "Mode for editing X resource files" t)


(setq auto-mode-alist
      (append '(("\\.Xresources$" . xrdb-mode)
		("\\.Xdefaults$"  . xrdb-mode)
		("*.\\.ad$"       . xrdb-mode))
	      auto-mode-alist))


(add-hook 'xrdb-mode-hook 'turn-on-font-lock) ; Syntax highlighting backup






;;; xrdb-mode-config.el ends here
