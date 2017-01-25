;;; defs.el --- Define startup path variable & recompile function

;; $Id: defs.el,v 1.1.1.1 2007/04/20 13:10:55 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; These are definitions of basic functions and variables that we use.
;; Don't edit this unless you know what you're doing :-)


;;; Code:


(defvar psgmlxpath nil		       ; path to psgmlx base directory
  "Path to psgmlx base directory, 
without the trailing \"/\"")



(defvar misc-settings nil		; switch for loading misc-settings
  "If non-nil, load psgmlx misc-settings. 
Intended for new emacs users. Switch on by putting 
\"(setq misc-settings t)\" in your .emacs file.")



(defvar winkeys nil			; switch for windows keybindings
  "If non-nil, turn on windows-style keybindings 
for cut, copy, paste, & undo. Switch on by putting 
\"(setq winkeys t)\" in your .emacs file.")



;; Function for re-compiling changed files

(defun compile-and-load-if-newer (file &optional noload)
  "Check if file.elc is newer than file.el or file 
(if file.el does not exist).  If so, compile the source 
file and load it.  Argument should not have the \".el\" suffix.

If the optional noload argument is non-nil, 
do not load the file after compilation."

(let ((source (or (and (file-exists-p (concat file ".el"))
		       (concat file ".el"))
		  (and (file-exists-p file)
		       file)
		  nil))
      (compiled (concat file ".elc")))
  (if source
      (progn
	(and (file-newer-than-file-p source compiled)
	     (byte-compile-file source))
	(unless noload
	  (load file)))
    nil)))





;;; defs.el ends here
