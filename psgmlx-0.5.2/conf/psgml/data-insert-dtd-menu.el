;;; data-insert-dtd-menu.el --- menu data for the "Insert DTD" menu

;; $Id: data-insert-dtd-menu.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.


;;; Commentary:

;; Syntax Summary 
;;  --------------
;;
;;  Entries are lists with at least two-items:
;;
;;  ("menu-text" "doctype" [optional local variables] )
;;
;; - escape additional quotes with backslashes \



;;; Code:

;;; Begin Menu section
(setq sgml-custom-dtd 
'(
  ;; BEGIN menu entries 


  ;; DocBook XML V4.2 - book

  ("DocBook XML V4.2 Book"
   "<?xml version=\"1.0\" standalone=\"no\"?>
<!DOCTYPE book PUBLIC \"-//OASIS//DTD DocBook XML V4.2//EN\"
         \"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd\">  
") 


  ;; DocBook XML V4.2 - chapter

  ("DocBook XML V4.2 Chapter"
   "<?xml version=\"1.0\" standalone=\"no\"?>
<!DOCTYPE chapter PUBLIC \"-//OASIS//DTD DocBook XML V4.2//EN\"
      \"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd\">"

   sgml-parent-document ("parent-book-filename.xml" "book" "chapter")
   
   ) 


  ;; DocBook XML V4.2 - article		

  ("DocBook XML V4.2 Article"
   "<?xml version=\"1.0\" standalone=\"no\"?>
<!DOCTYPE article PUBLIC \"-//OASIS//DTD DocBook XML V4.2//EN\"
     \"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd\">"
   ) 


  ;; DocBook XML V4.2 - refentry		

  ("DocBook XML V4.2 RefEntry (man page)"
   "<?xml version=\"1.0\" standalone=\"no\"?>
<!DOCTYPE refentry PUBLIC \"-//OASIS//DTD DocBook XML V4.2//EN\"
     \"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd\">"
   ) 





;; ========================================================
;;
;;     Simplified DocBook


  ;; Simplified DocBook XML - article

  ("Simplified DocBook XML - Article"
   "<?xml version=\"1.0\" standalone=\"no\"?>
<!DOCTYPE article PUBLIC \"-//OASIS//DTD Simplified DocBook XML V1.0//EN\"
       \"http://www.oasis-open.org/docbook/xml/simple/1.0/sdocbook.dtd\">
") 


  ;; Simplified DocBook XML - refentry

  ("Simplified DocBook XML - RefEntry (man page)"
   "<?xml version=\"1.0\" standalone=\"no\"?>
<!DOCTYPE refentry PUBLIC \"-//OASIS//DTD Simplified DocBook Refentry XML V1.0//EN\"
       \"http://www.oasis-open.org/docbook/xml/simple/1.0/sdocbookref.dtd\">
") 




  ;; DocBook SGML

  ("DocBook SGML 4.2 Article"
   "<!DOCTYPE article PUBLIC \"-//OASIS//DTD DocBook V4.0//EN\"> ")

  ("DocBook SGML 4.2 Chapter"
   "<!DOCTYPE chapter PUBLIC \"-//OASIS//DTD DocBook V4.0//EN\"> ")

  ("DocBook SGML 4.2 Book"
   "<!DOCTYPE book PUBLIC \"-//OASIS//DTD DocBook V4.0//EN\"> ")

  ("DocBook 3.1 Article"
   "<!DOCTYPE article PUBLIC \"-//OASIS//DTD DocBook V3.1//EN\"> ")

  ("DocBook 3.1 Chapter"
   "<!DOCTYPE chapter PUBLIC \"-//OASIS//DTD DocBook V3.1//EN\"> ")

  ("DocBook 3.1 Book"
   "<!DOCTYPE book PUBLIC \"-//OASIS//DTD DocBook V3.1//EN\"> ")



  ;; HTML 
   
  ("HTML 4.01 Transitional"
   "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> ")
  
  ("HTML 3.2"
   "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">")

  ("HTML 2.0"
   "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">")



  ;; END Menu Data
))  
;;; END Menu Section





;;; data-insert-dtd-menu.el ends here
