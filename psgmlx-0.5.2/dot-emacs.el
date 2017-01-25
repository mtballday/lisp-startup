;;; dot-emacs.el --- sample .emacs snippet for psgmlx

;; $Id: dot-emacs.el,v 1.1.1.1 2007/04/20 13:10:54 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;;  For regular use, put the following lines in your .emacs:


;;; Code:


;;; Preferences

(setq misc-settings			; Convenient startup settings 
      t)				; for new emacs users

;(setq winkeys				; Turn on Windows keybindings
;      t)				; (cut, copy, paste, undo) cua-mode




;;; Load the psgmlx init files 

(setq psgmlxpath "path-to-psgmlx-directory") ; path should NOT have a trailing slash.
(load (concat psgmlxpath "/init"))	     ; you need BOTH lines


;; Example:
;; 
;;        If you expanded the tarball in your 
;;        home directory and didn't change its name, you'd use
;; 
;;         (setq psgmlxpath "~/psgmlx-0.3")
;;         (load (concat psgmlxpath "/init"))



;;; dot-emacs.el ends here
