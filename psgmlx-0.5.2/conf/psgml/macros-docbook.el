;;; macros-docbook.el --- Keyboard macros for docbook 

;; $Id: macros-docbook.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Note: 
;;       More macros can be found at Bob DuCharme's PSGML Tricks page:
;;       http://www.snee.com/bob/sgmlfree/emcspsgm.html



;;; Code:

(add-hook 
 'sgml-mode-hook	;  Make this stuff apply only in sgml-mode
 (function 
  (lambda()
	     
;;; BEGIN docbook macros 



    ;; Insert <para></para>          
    ;; --------------------

    (fset 'insert-sgml-para-element
	  [?< ?p ?a ?r ?a ?> ?< ?/ ?p ?a ?r ?a ?> left left left left left left left])

    (global-set-key "p" 'insert-sgml-para-element)  ; Keybinding: "C-x p"





    ;; Tag Marked region with <para>     
    ;; -----------------------------

    (defun sgml-para ()
      "Insert para tags and position cursor. 
     (assumes cursor at region end)"
      (interactive)                        
      (insert "</para>")		        
      (goto-char (mark))                  
      (insert "<para>")                           
      (sgml-next-data-field))    
                                                 ; Bindings
                                                
    (define-key sgml-mode-map "\ep" 'sgml-para)   ;  "Alt-p"    
      ;  -- other possible keybindings --	  ;  
    ;(define-key sgml-mode-map "p" 'sgml-para)  ;  "C-c p"      	      
    ;(define-key sgml-mode-map "" 'sgml-para)   ;  "C-p" 





    ;; Tag Marked region with <emphasis>     
    ;; ---------------------------------

    (defun emph-tag ()
      "Tag marked region as an emphasis element 
    (assumes cursor at region end)."
      (interactive)
      (insert "</emphasis>")
      (goto-char (mark))
      (insert "<emphasis>")
      (sgml-next-data-field))
    (define-key sgml-mode-map "\e" 'emph-tag)	; Keybinding: "C-x e" 





;;; END docbook macros   
    )))




;;; macros-docbook.el ends here
