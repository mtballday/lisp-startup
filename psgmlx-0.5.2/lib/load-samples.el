;;; load-samples.el --- initialize and load sample files

;; $Id: load-samples.el,v 1.1.1.1 2007/04/20 13:10:55 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file first loads the initialization stuff, 
;; then presents a few sample files, each in a separate 
;; frame with a different SGML Color Theme.


;;; Code:

(setq misc-settings t)			; Convenient Settings

(setq psgmlxpath 
      (getenv "PSGMLX_DIR")) ; Assume install script is in psgmlx base directory  

(load (concat psgmlxpath "/init"))	; Load init file


;; Make frames with separate themes, load them with sample files

(let ((color-theme-is-global nil))	; Allows each frames to 
                                        ; have separate themes
 (select-frame (make-frame))
 (color-theme-sgml-blue-lo)             ; Blue low-contrast theme
 (find-file "examples/slides.xsl")

 (select-frame (make-frame))
 (color-theme-sgml-green-hi)            ; Green High theme
 (find-file "example.css")

 (select-frame (make-frame))
 (color-theme-sgml-light)               ; Light theme 
 (find-file "docbook-slides.xml")
 (sgml-next-trouble-spot)		; Hack to fontify  
 (beginning-of-buffer)			; the entire buffer

 (select-frame (make-frame))
 (color-theme-sgml-blue-hi)             ; Blue High theme 
 (find-file "simple-docbook.xml")
 (sgml-next-trouble-spot)		; Hack to fontify  
 (beginning-of-buffer)			; the entire buffer

 (select-frame (make-frame))
 (color-theme-sgml-green-lo)            ; Green Low theme
 (find-file "../doc/intro")

)


;;; load-samples.el ends here


