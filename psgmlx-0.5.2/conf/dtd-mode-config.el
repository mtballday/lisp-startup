;;; dtd-mode-config.el --- config file for the tdtd package

;; $Id: dtd-mode-config.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Note: The tdtd package provides a major mode for editing dtds.  
;;       Author: Tony Graham <tkg@menteith.com>
;;       Homepage: http://www.menteith.com/tdtd/


;;; Code:


(autoload 'dtd-mode "tdtd" 		 
  "Major mode for SGML and XML DTDs." t) 

(autoload 'dtd-etags "tdtd"
  "Execute etags on FILESPEC and match on 
DTD-specific regular expressions."  t)

(autoload 'dtd-grep "tdtd" 
  "Grep for PATTERN in files matching FILESPEC." t)

(setq auto-mode-alist
      (append (list
	       '("\\.dcl$" . dtd-mode)
	       '("\\.cat$" . dtd-mode)
	       '("catalog$" . dtd-mode)
	       '("CATALOG$" . dtd-mode)
	       '("\\.dec$" . dtd-mode)
	       '("\\.dtd$" . dtd-mode)
	       '("\\.ele$" . dtd-mode)
	       '("\\.ent$" . dtd-mode)
	       '("\\.mod$" . dtd-mode))
	      auto-mode-alist))



(add-hook 'dtd-mode-hooks 'turn-on-font-lock) ; Syntax highlighting backup




;;; dtd-mode-config.el ends here
