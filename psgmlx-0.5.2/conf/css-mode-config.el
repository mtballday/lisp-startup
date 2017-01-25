;;; css-mode-config.el --- config file for the css-mode package

;; $Id: css-mode-config.el,v 1.1.1.1 2007/04/20 13:10:55 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Note: The css-mode package provides a major mode for editing css stylesheets.  
;;       Author: Lars Marius Garshol <larsga@ifi.uio.no>
;;       Homepage: http://www.stud.ifi.uio.no/~larsga/download/css-mode.html


;;; Code:

(autoload 'css-mode "css-mode")

(setq auto-mode-alist       
      (cons '("\\.css\\'" . css-mode) 
	    auto-mode-alist))






;;; css-mode-config.el ends here
