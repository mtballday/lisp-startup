;;; xsl-mode-config.el --- config file for the xslide package

;; $Id: xsl-mode-config.el,v 1.1.1.1 2007/04/20 13:10:55 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.


;;; Commentary:

;; Note: The xslide package provides a major mode for editing xsl stylesheets.  
;;       Author: Tony Graham <tkg@menteith.com>
;;       Homepage: http://www.menteith.com/xslide/


;;; Code:


(autoload 'xsl-mode "xslide" 
  "Major mode for XSL stylesheets." t)

(setq auto-mode-alist
      (append (list
	       '("\\.xsl" . xsl-mode)
	       '("\\.xslt" . xsl-mode)
	       '("\\.fo" . xsl-mode))
	      auto-mode-alist))



(add-hook 'xsl-mode-hook 'turn-on-font-lock) ; Syntax highlighting backup





;;; xsl-mode-config.el ends here
