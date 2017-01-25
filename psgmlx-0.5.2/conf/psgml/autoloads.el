;;; autoloads.el --- top-level psgml config file        

;; $Id: autoloads.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.


;;; Commentary:

;; Note : The main configuration for psgml is in settings.el



;;; Code:


;; sgml-mode
(autoload 'sgml-mode "psgml" 
  "Major mode to edit SGML files." t)

;; xml-mode 
(autoload 'xml-mode "psgml" 
  "Major mode to edit XML files." t)
(setq auto-mode-alist
      (append (list 
	       (cons "\\.xml\\'" 'xml-mode)
	       (cons "\\.xsd\\'" 'xml-mode)
	       (cons "\\.xhtm\\'" 'xml-mode)
	       (cons "\\.xhtml\\'" 'xml-mode)
	       ) auto-mode-alist))


;;  (add-hook 'sgml-mode-hook		; Not sure whether this is needed  
;;  	  (function			
;;  	   (lambda()
;;  	     (font-lock-mode)
;;  	     )))
 


;; sgml-html-mode

(setq auto-mode-alist
      (append 
       '(("\\.html$" . sgml-html-mode)
 	 ("\\.htm$"  . sgml-html-mode)
 	 ) auto-mode-alist))





;; psgml-xpointer

(autoload 'sgml-xpointer		; Generates Xpointer for current
  "psgml-xpointer" nil t)		; element:   "M-x sgml-xpointer"






;;; autoloads.el ends here
