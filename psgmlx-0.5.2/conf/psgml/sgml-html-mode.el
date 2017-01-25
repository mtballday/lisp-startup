;;; sgml-html-mode.el --- HTML mode derived from sgml-mode 
 
;; $Id: sgml-html-mode.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Note: This is from Markus Hoenicka's NTSGML pages 
;;   http://ourworld.compuserve.com/homepages/hoenicka_markus/ntsgml.html
;; And from psgml-html for XEmacs, by Alastair Burt.
;; 

;;; Code:


;; define sgml-html-mode


(provide 'sgml-html-mode)
(require 'psgml)
(require 'derived)
(eval-when-compile
  (require 'browse-url))


(define-derived-mode sgml-html-mode sgml-mode "HTML"
  "This version of html mode is just a wrapper around sgml mode."

  (make-local-variable 'sgml-declaration)
  (make-local-variable 'sgml-default-doctype-name)
  (setq 
   sgml-declaration  (concat psgmlxpath "/lib/html.decl")
   sgml-default-doctype-name    "html"
   sgml-auto-insert-required-elements t
   sgml-always-quote-attributes t
   sgml-indent-step             2
   sgml-indent-data	        t
   sgml-minimize-attributes     nil
   sgml-omittag                 t
   sgml-shorttag                t
   sgml-inhibit-indent-tags     '("pre")
   ;; menus for creating new documents
   sgml-custom-dtd
   '(
     ( "HTML 4.01 Strict"
       "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\">" )
     ( "HTML 4.01 Transitional"
       "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">")
     ( "HTML 4.01 Frameset"
       "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\">" )
     )
   )
  (sgml-build-custom-menus)
;; Add HTML submenu to View Menu  
  (easy-menu-add-item
   sgml-view-menu nil
   '("HTML" 
   ["View in Browser" browse-url-of-buffer
    (buffer-file-name (current-buffer))]
   ["View in W3" w3-preview-this-buffer t]
   ["HTML-Quote Region" html-quote-region t]
   ) "Fold Element")
  )




;;;###autoload
(defun html-quote-region (begin end)
  "\"Quote\" any characters in the region that have special HTML meanings.
This converts <'s, >'s, and &'s into the HTML commands necessary to
get those characters to appear literally in the output."
  (interactive "r")
  (save-excursion
    (goto-char begin)
    (while (search-forward "&" end t)
      (forward-char -1)
      (delete-char 1)
      (insert "&amp;")
      (setq end (+ 4 end)))
    (goto-char begin)
    (while (search-forward "<" end t)
      (forward-char -1)
      (delete-char 1)
      (insert "&lt;")
      (setq end (+ 3 end)))
    (goto-char begin)
    (while (search-forward ">" end t)
      (forward-char -1)
      (delete-char 1)
      (insert "&gt;")
      (setq end (+ 3 end)))))


;;;###autoload
(autoload 'sgml-html-mode "sgml-html-mode" "SGML-HTML mode." t)

;; (defvar sgml-html-menu
;;   (cons "HTML"
;; 	(append '(["View in Browser" browse-url-of-buffer
;; 		   (buffer-file-name
;; 		    (current-buffer))]
;; 		  ["View in W3" w3-preview-this-buffer t]
;; 		  "---"
;; 		  ["HTML-Quote Region" html-quote-region t]
;; 		  "---")
;; 		(cdr sgml-main-menu))))

(defun sgml-html-netscape-file ()
  "Preview the file for the current buffer in Netscape."
  (interactive)
  (highlight-headers-follow-url-netscape
   (concat "file:" (buffer-file-name (current-buffer)))))

(defun sgml-html-kfm-file ()
  "Preview the file for the current buffer in kfm."
  (interactive)
  (highlight-headers-follow-url-kfm
   (concat "file:" (buffer-file-name (current-buffer)))))



;;; sgml-html-mode.el ends here
