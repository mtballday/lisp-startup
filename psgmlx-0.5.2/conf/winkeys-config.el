;;; winkeys-config.el --- config file for CUA-mode, for Windows-style keybindings

;; $Id: winkeys-config.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; Note: The CUA-mode package provides complete emulation of the 
;;       standard CUA key bindings (Motif/Windows/Mac GUI).
;;       Author: Kim F. Storm <stormware@get2net.dk>
;;       Homepage: http://hjem.get2net.dk/storm/emacs/



;;; CUA Mode - Windows Keybindings in Emacs

;;	C-z	-> undo
;;	C-x	-> cut
;;	C-c	-> copy
;;	C-v	-> paste



(require 'cua-mode)    
(CUA-mode t)



;;; winkeys-config.el ends here
