;;; dircolors.el -- provide the same facility of ls --color inside emacs

;; Copyright (C) 2000  Padioleau yoann <padiolea@irisa.fr>
;; Copyright (C) 2000  Besson, Frederic <fbesson@irisa.fr>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;; Emacs Lisp Archive Entry
;; Filename: dircolors.el
;; Author: Padioleau Yoann <padiolea@irisa.fr>
;; Contributor: Besson Frederic <fbesson@irisa.fr>
;; Version: 1.1

;;; Changes
;;  1.1 handles now Xemacs

;;; Goal
; try to colorize the buffers of emacs as ls --color do in a terminal
;  so if you try C-x b TAB or C-x C-f, you will see directory in blue
;  c source file in yellow, object file in gray, ....
;  it helps a lot to find the file you want to open

;;; Usage
; Add the following lines to ~/.emacs or an equivalent
;         (require 'dircolors)
; you can customize this module by :
;   - changing the colors of some faces for example with
;          (set-face-foreground 'dircolors-face-asm "blue")
;   - adding some faces/extension for example with
;          (make-face 'myface-modula) 
;          (set-face-foreground 'myface-modula "yellow")
;          (setq dircolors-extension 
;                (cons '(("mod" "md3") myface-modula) 
; 	             dircolors-extension)
;   - make dircolors working for other emacs buffer
;          (add-hook  'completion-list-mode-hook 'dircolors)
;          (remove-hook 'completion-list-mode-hook 'dircolors)

;;; Code

;; generic functions not included in emacs

(defun join-string(xs &optional sep)
  (cond ((null xs) "")
	((null (cdr xs)) (car xs))
	(t (concat (car xs) (or sep " ") (join-string (cdr xs) sep)))))

(defun map-apply(func xs)
  (mapcar #'(lambda (l)(apply func l)) xs))

;; here start the real code

;; configuration variables
(defvar dircolors-face-color

  '(
    (dircolors-face-dir            "blue2"        )
    (dircolors-face-doc            "MediumTurquoise")
    (dircolors-face-html           "Plum"           )
    (dircolors-face-package        "IndianRed"      )
    (dircolors-face-tar            "OrangeRed"      )
    (dircolors-face-dos            "LimeGreen"      )
    (dircolors-face-sound          "LightBlue"      )
    (dircolors-face-img            "Salmon"         )
    (dircolors-face-ps             "Violet"     )
    (dircolors-face-backup         "Magenta"        )
    (dircolors-face-make           "Khaki"          )
    (dircolors-face-paddb          "Orange"         )
    (dircolors-face-lang           "Yellow"         )
    (dircolors-face-emacs          "Sienna"    )
    (dircolors-face-lang-interface "Goldenrod"      )
    (dircolors-face-yacc           "Coral"          )
    (dircolors-face-objet          "DimGray"        )
    (dircolors-face-asm            "Tan"            )
    (dircolors-face-compress       "Sienna"         )
    ))

(defvar dircolors-extension
  '(
    (("txt" "doc" "tex" "texi" "man" 
      (r "README") (r "readme")) dircolors-face-dir)
    (("htm" "html" "html\\.gz" "htm\\.gz") dircolors-face-html)
    (("rpm" "deb" ) dircolors-face-package)
    (("tar" "tgz" "tar.gz" "tar.bz2" "zip" ) dircolors-face-tar)
    (("cmd" "exe" "com" "bat") dircolors-face-dos)
    (("mp3" "s3m" "mod" "au" "wav") dircolors-face-sound)
    (("jpg" "gif" "bmp" "xbm" "tif" "xpm" "jpeg") dircolors-face-img)
    (("ps" "pdf" "ps\\.gz" ) dircolors-face-ps)
    (("bak" "BAK" (r "\\.save"))dircolors-face-backup)
    (((r "akefile")) dircolors-face-make)
    (("db") dircolors-face-paddb)
    (("ml" "hs" "lhs" "scm" "sc" "p" "pas" "c" "cpp" "c\\+\\+" 
      "cc" "pm" "pl" "m" "bet") dircolors-face-lang)
    (( "el" "emacs") dircolors-face-emacs)
    (("mli" "h" "hpp" "hh" "l" "y" "l\\+\\+" "y\\+\\+"
      "ll" "yy") dircolors-face-yacc)
    (("class" "o" ) dircolors-face-objet)
    (("asm" "s" "S" ) dircolors-face-asm)
    (("gz" ) dircolors-face-compress); last because can conflict
    )
  "the syntax is (extension list  face), where extension can be either of the
   simple form string in which case it is interpreted as an extension
   for example \"txt\" will colorise all string that ends with .txt
   or can be of the form (r regexp)"
  )

;; Internal variable
(defvar dircolors-font-lock-keywords nil )

;; compiling

(defun dircolors-compile-extension (e)
  " string | ( r * string)  -> regexp"
  (if (stringp e)
      (concat  "\\w*\\." e "\\>")
    (concat "\\w*" (cadr e) "\\w*\\>") ;regexp '(r "reg")
    ))


(defun dircolors-compile-extension-list (l face)
  "(extension list * face) -> regexp list * face"
  (list
   (join-string (mapcar 'dircolors-compile-extension l) "\\|")
   face)
  )



(defun dircolors-boot ()
  "Initialisation..."
  ;; create faces
  (map-apply (lambda (symb face)

	       (set-face-foreground (make-face symb) face)
	       )
	     dircolors-face-color)
  ;; compile spec
  (setq dircolors-font-lock-keywords
	(cons
	 '("\\w*/"  dircolors-face-dir)
	 (map-apply (lambda (l face) (dircolors-compile-extension-list l face))
		    dircolors-extension)
	 ))
  )


(defun dircolors()
  (interactive)
  (save-excursion
    (let ( (rd-only buffer-read-only))
      (condition-case nil
	  (progn
	    ;; chars _ - + . are word constituent
	    (modify-syntax-entry ?_  "w")
	    (modify-syntax-entry ?-  "w")
	    (modify-syntax-entry ?+  "w")
	    (modify-syntax-entry ?.  "w")
	    (toggle-read-only -1)

	  ;; direct search seems faster than font-lock-mode
	    (map-apply 
	     (lambda (regexp face)
	       (goto-char (point-min))
	       (while (re-search-forward regexp (point-max) t)
		 (let ( (begin (match-beginning 0)) (end (match-end 0)))
		   (remove-text-properties begin end '(face nil))
		   (add-text-properties begin end
					(list 'face face)))
		 )
	       )
	     dircolors-font-lock-keywords)
	    (toggle-read-only (if rd-only 1 -1 ))
	    )
	(t    (toggle-read-only (if rd-only 1 -1)))
	)
      )))

;;; run
(dircolors-boot)

(add-hook 'completion-list-mode-hook 'dircolors)
(add-hook 'buffer-menu-mode-hook     'dircolors)


(provide 'dircolors)
