;;; default-theme.el --- select a default color theme 
 
;; $Id: default-theme.el,v 1.1.1.1 2007/04/20 13:10:54 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file selects the default color theme


;;; Code:

;; Recompile source files if needed
(compile-and-load-if-newer  (concat pkgpath "/color-theme" ) 'noload)
(compile-and-load-if-newer  (concat pkgpath "/color-theme-sgml" ) 'noload)

;; Load both theme packages
(require 'color-theme)
(require 'color-theme-sgml)


;;; Select default theme 
;;  (can also do this in your .emacs - after loading psgmlx)

;(color-theme-sgml-blue-lo)     	; Blue theme - low contrast

;(color-theme-sgml-light)

;(color-theme-sgml-blue-hi)

;;; Other Themes for SGML:
;;  ----------------------
;;
;;  (color-theme-sgml-light)
;;  (color-theme-sgml-blue-lo)
;;  (color-theme-sgml-green-lo)
;;  (color-theme-sgml-blue-hi)
;;  (color-theme-sgml-green-hi)
;;  (color-theme-sgml-black-lo)
;;  (color-theme-sgml-black-lo-2)
;;  (color-theme-sgml-black-hi)
;;  (color-theme-sgml-black-hi-2)



;;; Startup with Multiple Frames & Themes
;;  -------------------------------------
;;
;;  To create additional frames, each with its own theme,
;;  (The theme called above will be the default.)
;;
;;  Uncomment these lines:
;;
;; (let ((color-theme-is-global nil))
;;   (select-frame (make-frame))
;;   (color-theme-sgml-green-lo) ;theme 
;;   (select-frame (make-frame))
;;   (color-theme-sgml-light) ; theme
;;   (select-frame (make-frame))
;;   (color-theme-sgml-blue) ; theme
;;   )




;;; default-theme.el ends here
