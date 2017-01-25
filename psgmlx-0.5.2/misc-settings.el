;;; misc-settings.el --- basic settings

;; $Id: misc-settings.el,v 1.1.1.1 2007/04/20 13:10:54 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; If you're new to emacs, these might be helpful


;;; Code:

(setq inhibit-startup-message t) ; Eliminate FSF startup msg
(setq frame-title-format "%b")   ; Put filename in titlebar
(setq visible-bell t)            ; Flash instead of beep
(set-scroll-bar-mode 'right)     ; Scrollbar placement
(show-paren-mode t)              ; Blinking cursor shows matching parentheses
(setq column-number-mode t)	 ; Show coumn number of current cursor location


(cond ((fboundp 'global-font-lock-mode)	; Turn on font-lock (syntax highlighting)
       (global-font-lock-mode t)        ; in all modes that support it
       (setq font-lock-maximum-decoration t))) ; Maximum colors


 
(delete-selection-mode t)        ; Delete/Replace Marked Text (Windows-like)
(set 'mark-even-if-inactive t)   ; use mark/region even if unhighlighted

(setq backup-by-copying t)       ; Retain ownership/name of backup files
(setq delete-auto-save-files t)  ; Saving deletes #backupfiles# 

(setq require-final-newline t)   ; put LINEFEED after last line


(require 'dircolors)			; colored file listings in minibuffer


;(setq ps-font-family 'Helvetica)	; Better looking printouts
;(setq ps-print-color-p nil)
;(setq tex-dvi-view-command "xdvi")
;(setq tex-dvi-print-command "lpr")




;;; misc-settings.el ends here
