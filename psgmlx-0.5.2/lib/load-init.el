;;; load-init.el --- loads init file, compiles cnofig files

;; $Id: load-init.el,v 1.1.1.1 2007/04/20 13:10:55 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Sets base path, calls init (for compiling config files).


;;; Code:

;; Note: Must evaluate defs.el before evaluating these statements


(unless psgmlxpath 
  (setq psgmlxpath 
	(getenv "PSGMLX_DIR")))


(message 
 "I'm assuming psgmlx is in %s"		; Some feedback
 psgmlxpath)
 

(setq misc-settings t)			; init makes use of these settings

(load 
 (concat				; load init, compile
  psgmlxpath "/init"))			; whatever's left




;;; load-init.el ends here
