;;; macros-sgml.el --- Generic keyboard macros for sgml-mode

;; $Id: macros-sgml.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

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
	     
;;; BEGIN sgml macros 


    ;; Copy Current Element to Buffer
    ;; -------------------------------

    (defun sgml-copy-element ()
      "Copy the current element to the buffer."
      (interactive)
      (sgml-backward-up-element)
      (let ((start (point)))
	(sgml-forward-element)
	(kill-ring-save start (point))))
    
    (define-key sgml-mode-map "w" 'sgml-copy-element) 





    ;;  Fill Element and Save File
    ;;  ---------------------------

    ;; sgml-fill-element is PSGML's SGML-intelligent way to rejustify
    ;; an element. After making edits to a paragraph, hit F2 to rejustify 
    ;; the element and save your work.

    (defun sgml-fill-and-save ()
      "Rejustify element at cursor and save file."
      (interactive)
      (sgml-fill-element (sgml-find-element-of (point)))  
      (save-buffer))
                       
    (define-key sgml-mode-map [f2] 'sgml-fill-and-save) ; see psgml-edit.el



;;; END sgml macros   
    )))



;;; macros-sgml.el ends here
