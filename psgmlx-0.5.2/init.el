;;; init.el --- Main Startup File: sets load-path, loads packages & libraries

;; $Id: init.el,v 1.1.1.1 2007/04/20 13:10:54 rich Exp $ 

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file sets the load-path, then loads all the config files


;;; Code:

(load (concat psgmlxpath "/lib" "/defs")) ; Load startup functions


(let (					; Define path variables
      ( basepath   psgmlxpath )
      ( confpath   (concat psgmlxpath "/conf"))
      ( psgmlconf  (concat psgmlxpath "/conf/psgml"))
      ( libpath    (concat psgmlxpath "/lib"))
      ( pkgpath    (concat psgmlxpath "/packages"))
      ( psgmlpath  (concat psgmlxpath "/packages/psgml"))
      ( tdtdpath   (concat psgmlxpath "/packages/tdtd"))
      ( xslidepath (concat psgmlxpath "/packages/xslide")) )

 
  (compile-and-load-if-newer		; Recompile _this_ file if needed
   (concat basepath "/init") 'noload)

  (compile-and-load-if-newer		; Recompile definitions if needed
   (concat libpath "/defs") 'noload)

;;   (compile-and-load-if-newer		; Recompile .emacs if needed
;;    "~/.emacs" 'noload)

  (setq load-path			; Set the load-path
	(append
	 (list basepath)
	 (list confpath)
	 (list psgmlconf)
	 (list libpath)
	 (list pkgpath)
	 (list psgmlpath)
	 (list tdtdpath)
	 (list xslidepath)
	 load-path))



;;; Load configs for various packages, recompile if needed


  (compile-and-load-if-newer 
   (concat confpath "/css-mode-config")) ; css-mode

  (compile-and-load-if-newer 
   (concat confpath "/xrdb-mode-config")) ; xrdb-mode

  (compile-and-load-if-newer 
   (concat confpath "/xsl-mode-config")) ; xsl-mode

  (compile-and-load-if-newer 
   (concat confpath "/dtd-mode-config")) ; dtd-mode

  (compile-and-load-if-newer		    ; psgml init file
   (concat confpath "/load-psgml-configs")) ; loads the psgml config files


  (if winkeys				; Windows-style (cut, copy , paste, & undo) 
      (compile-and-load-if-newer	; keybindings. 
       (concat confpath			; Activate with     (setq winkeys t)
	       "/winkeys-config")))	; in your .emacs



;;; Load general stuff

  (if misc-settings			; Misc convenient settings for new users
      (compile-and-load-if-newer	; Activate with 
       (concat basepath			;                (setq misc-settings t)
	       "/misc-settings")))	; in your .emacs 


  (compile-and-load-if-newer		; Load the default sgml color theme
   (concat basepath "/default-theme"))  
  )






;;; init.el ends here
