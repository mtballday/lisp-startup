;;; nbi-fazy.el --- font-lock and lazy-lock customizations for Emacs >=19.29.
;; Copyright (C) 1994, 1995 Ulrik Dickow.

;; Author: Ulrik Dickow <dickow@nbi.dk>.
;; Version: $Id: nbi-fazy.el,v 1.1.1.1 2007/04/20 13:10:52 rich Exp $
;; Keywords: local faces fonts colors
;; Homepage: <URL:http://www.nbi.dk/~dickow/emacs/>

;; This file is not part of GNU Emacs. Nonetheless, it is released
;; in accordance with the terms of the GNU General Public License as
;; published by the Free Software Foundation.

;; Usually loaded from ~/.emacs. This is *not* a general purpose library.
;; This file should only be loaded if window-system is non-nil.
;; If you don't like the default faces, you can customize them by putting lines
;; like these in your ~/.Xdefaults:
;;    Emacs.font-lock-keyword-face.attributeBold:       on
;;    Emacs.font-lock-keyword-face.attributeForeground: ForestGreen

;; Former names: nbi-faces, nbi-faces-3.

;; Recent changes:
;;  1.10 1995/10/23: Added `outline-mode' and `sh-mode' to the list.
;;  1.9  1995/09/19: Only comments modified.
;;  1.8  1995/09/19: Added `idl-mode' to `font-lock-enable-list'.
;;  1.7  1995/09/05: html-font-lock-keywords --> html-helper-font-lock-keywords
;;  1.6  1995/08/24: Added `change-log-mode' to `font-lock-enable-list'.
;;  1.5  1995/08/11: Cosmetic TeX keyword changes.  RCS introduced.

(or window-system
    (error "Can't use fonts and colors on an ASCII terminal"))

;;;; Font lock mode --- a minor mode to make syntax dependent fonts & colors.

;; The decoration level must be set before loading font-lock (new in 19.29).
;; If it's already loaded, we loose and would have to do stuff by hand.
(setq font-lock-maximum-decoration t)
(require 'font-lock)

;; Ulrik Dickow's font-lock support for KUMAC, Fortran and HTML helper mode.
;; Protect against new versions with (ud's) built-in font-lock support.
(eval-after-load "kumac-mode" '(or (boundp 'kumac-font-lock-keywords)
				   (load "kumac-font" t)))
;; 19.29's fortran.el has built-in font-lock support, a bit better than this.
;; (eval-after-load "fortran" '(load "fort-font" t))
(add-hook 'html-helper-load-hook
	  '(lambda () (or (boundp 'html-helper-font-lock-keywords)
			  (load "html-font" t))))

(defvar font-lock-enable-list ;; (`TeX-mode' is AUC TeX's, `tex-mode' is std)
  '(tex-mode TeX-mode c-mode c++-mode emacs-lisp-mode perl-mode fortran-mode
	     kumac-mode mail-mode rmail-mode rmail-summary-mode dired-mode
	     makefile-mode shell-mode html-helper-mode change-log-mode
	     idl-mode outline-mode sh-mode ada-mode)
  "List of modes for which to automatically turn on font lock mode.")

;; Add hooks to enable font lock mode in various major modes (hairy lisp code!)
;; Should use a single create-buffer hook instead if it appears in Emacs.
;; For several modes, a find-file-hook would be enough.
(mapcar '(lambda (x)
	   (add-hook (intern (concat (symbol-name x) "-hook"))
		     (function turn-on-font-lock)))
	font-lock-enable-list)

;; I like these keywords better (Ulrik Dickow <dickow@nbi.dk>).
(setq dired-font-lock-keywords
      '(;; Files marked for deletion
	("^D.*$" . font-lock-string-face)
	;; Files with other mark
	("^[^ ].*$" . font-lock-function-name-face)
	;; Symlinks
	("\\([^ ]+\\) -> [^ ]+$" . font-lock-reference-face)
	;; Directory headers
	("^  \\(/.+\\)$" 1 font-lock-type-face)
	;; Files that are subdirectories
	("^..d.* \\([^ ]+\\)$" . 1)))

;(setq rmail-summary-font-lock-keywords
;  '(("^\\s *[0-9]+D.*" . font-lock-string-face)
;    ("^\\s *[0-9]+-.*" . font-lock-keyword-face)))

;; I don't like 19.29's Rmail/mail fontification.  Just merge a bit of it
;; with my old setup. (19.29 is case sensitive for mail font-lock).
(setq rmail-font-lock-keywords
      '(("^\\(From:\\) \\(.*\\)"
	 (1 'italic) (2 font-lock-keyword-face))
	("^\\(Subject:\\) \\(.*\\)"
	 (1 'italic) (2 font-lock-function-name-face))
	("^\\(To:\\|C[Cc]:\\) \\(.*\\(\n[ \t]+[^ \t\n].*\\)*\\)"
	 (1 'italic) (2 font-lock-type-face))
	("^\\(Date:\\) \\(.*\\)"
	 (1 'italic) (2 font-lock-variable-name-face))
;;	("^\\(X-[A-Za-z0-9-]+:\\) \\(.*\\)" ; X-stra headers, like in rmail.el
;;	 (1 'italic) (2 font-lock-string-face))
	("^[ \t]*\\(\\(\\([A-Za-z]+>\\|[|:>]\\)[ \t]*\\)+.*\\)" ; Citation
	 1 font-lock-reference-face)))
;;
(setq mail-font-lock-keywords
      (cons (list (concat "^\\(" (regexp-quote mail-header-separator) "\\)$")
		  1 'font-lock-comment-face) ; From 19.29's sendmail.el
	    rmail-font-lock-keywords))

;;(if (string-lessp "19.29.89" emacs-version)
;;    () ; Equivalent code will be in 19.30 (hopefully)
;;
(setq tex-font-lock-keywords
  ;; Regexps updated by Ulrik Dickow <dickow@nbi.dk>, now w/ LaTeX2e.
  '(("\\\\\\(begin\\|end\\|newcommand\\){\\([a-zA-Z0-9\\*]+\\)}"
     2 font-lock-function-name-face)
    ("\\\\\\(cite\\|label\\|pageref\\|ref\\){\\([^} \t\n]+\\)}"
     2 font-lock-reference-face)
    ("^[ \t]*\\\\def\\\\\\(\\(\\w\\|@\\)+\\)" 1 font-lock-function-name-face)
    "\\\\\\([a-zA-Z@]+\\|.\\)"
    ;; It seems a bit dubious to use `bold' and `italic' faces since we might
    ;; not be able to display those fonts.
    ;; LaTeX2e: \emph{This is emphasized}.
    ("\\\\emph{\\([^}]+\\)}" 1 'italic keep)
    ;; LaTeX2e: \textbf{This is bold}, \textit{...}, \textsl{...}
    ("\\\\text\\(\\(bf\\)\\|it\\|sl\\){\\([^}]+\\)}"
     3 (if (match-beginning 2) 'bold 'italic) keep)
    ;; Old-style bf/em/it/sl. Stop at `\\' and un-escaped `&', for good tables.
    ("\\\\\\(\\(bf\\)\\|em\\|it\\|sl\\)\\>\\(\\([^}&\\]\\|\\\\[^\\]\\)+\\)"
     3 (if (match-beginning 2) 'bold 'italic) keep)))
;;
;; And now for a shrewd side-effect hack (effectful for 19.29 font-lock.el)
;; that will modify all TeX-related defaults in `font-lock-defaults-alist'
;; so that opening parentheses don't confuse `beginning-of-defun':
;;(setcar (nthcdr 4 (assq 'bibtex-mode font-lock-defaults-alist))
;;	'((?$ . "\"") (?\( . ".") (?\[ . ".") (?\{ . ".")))
;;; <19.29.90 code ends here.

;(defun font-lock-add-to-defaults-alist (mode defaults)
;  (setq font-lock-defaults-alist (cons (cons mode defaults)
;				       (delq 'mode font-lock-defaults-alist))))
;; or non-destructively:
;(defun font-lock-add-to-defaults-alist (mode defaults)
;  (add-to-list 'font-lock-defaults-alist (cons mode defaults)))
;;
;(font-lock-add-to-defaults-alist 'foo-mode '(foo-font-lock-keywords t))

;; Changing defaults

;; We don't need to fiddle with maximum size when we've got lazy-lock
;(add-hook 'rmail-mode-hook
;	  (lambda ()
;	    (make-local-variable 'font-lock-maximum-size)
;	    (setq font-lock-maximum-size 1000000)))
(add-hook 'fortran-mode-hook
	  (lambda ()
	    (make-local-variable 'font-lock-variable-name-face)
	    (setq font-lock-variable-name-face 'default)))

;;; Simon Marshall's lazy-lock from the LCD. An addition to font-lock.
;;(autoload 'turn-on-lazy-lock "lazy-lock"
;;  "Unconditionally turn on Lazy Lock mode.")
;; Instead of autoload I try to load now, to know whether it's in load-path:
(if (load "lazy-lock" t)
    (progn
;; Minimum buffer size in bytes for demand-driven fontification (default 25k).
;      (setq font-lock-maximum-size  ; Default 150k/300k in 19.29.
;	    (setq lazy-lock-minimum-size (* 50 1024)))
;      (setq lazy-lock-stealth-time nil) ; nil = turn off stealth
;; Maximum size of a chunk of stealth fontification (default 250 in >19.28).
;      (setq lazy-lock-stealth-lines 500)
;; Emacs 19.29 is very slow when walking windows (more than one window present)
      (setq lazy-lock-walk-windows nil) ; nil = only fontify selected window
;;
      (add-hook 'font-lock-mode-hook 'turn-on-lazy-lock)))
