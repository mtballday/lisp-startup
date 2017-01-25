;;; load-psgml-configs.el --- psgml config initialization file        

;; $Id: load-psgml-configs.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.


;;; Commentary:

;; Note : This file loads the psgml config files
;;        and recompiles them, if needed.

;; If you change the psgml config filenames or layout, 
;; make the corresponding change to this file.


;;; Code:


;; Load config files (recompile if needed)
  (compile-and-load-if-newer (concat psgmlconf "/autoloads"))
  (compile-and-load-if-newer (concat psgmlconf "/settings"))
  (compile-and-load-if-newer (concat psgmlconf "/faces"))
  (compile-and-load-if-newer (concat psgmlconf "/data-custom-markup-menu"))
  (compile-and-load-if-newer (concat psgmlconf "/data-insert-dtd-menu"))
  (compile-and-load-if-newer (concat psgmlconf "/macros-sgml"))
  (compile-and-load-if-newer (concat psgmlconf "/macros-docbook"))
  (compile-and-load-if-newer (concat psgmlconf "/sgml-html-mode"))



;;; load-psgml-configs.el ends here
