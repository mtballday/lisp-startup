;;; settings.el --- main settings for psgml

;; $Id: settings.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.


;;; Commentary:

;; These are the main settings you may want/need to change,


;;; Code:

;;; Paths to declarations
;;  ---------------------

;; (setq sgml-declaration  "/usr/lib/sgml/declaration/docbook.dcl")
;; (setq sgml-xml-declaration "/usr/lib/sgml/declaration/xml.dcl")

(setq sgml-xml-declaration (concat libpath "/xml.dcl"))


;;; Information Display
;;  -------------------
(setq sgml-live-element-indicator t)	; Indicate current element in modeline?



;;; Behavior
;;  ---------

(setq sgml-auto-activate-dtd t)		; Immediately parse dtd on load?

(setq sgml-offer-save nil)		; Ask to save before validating?

(setq sgml-catalog-files '("/etc/sgml/catalog"))



;;; Indentation
;;  -----------

(setq sgml-indent-data t)		; Indent text along with Markup?



;;; Inserting Markup
;;  ================

(setq sgml-auto-insert-required-elements t) ; Insert required subelements? 
;;    (You want this one.)


(setq					; Fil element with commented-out
 sgml-insert-missing-element-comment	; commented-out list of valid tags?
 nil)					
;;   (This one is annoying. Leave it to nil.)


(setq sgml-balanced-tag-edit t)		; Insert both start AND end tags?
;;    (You want this one.)


(setq sgml-normalize-trims t)		; Trim white spaace when adding end-tag?
;;   (Not relevant if balanced-tag-edit is t)


(setq sgml-insert-end-tag-on-new-line nil) ; Put end-tag on new line?
;; Applies when inserting both start/end tags. 


(setq sgml-leave-point-after-insert  ; Put cursor AFTER inserted tags?
      nil)
;; If t, the point will remain after inserted tag(s).
;; If nil, the point will be placed before the inserted tag(s).


(setq sgml-insert-defaulted-attributes nil)
;; Controls whether defaulted attributes (not #FIXED) are inserted 
;; explicitly or not. nil means don't insert, t means insert.





;;; Menu Configuration
;;  ==================

;; Max num of entries per submenu
;;    (default is 36)
(setq sgml-max-menu-size 24)


;; Maximum number of characters used from the first and last entry
;; of a submenu to indicate the range of that menu
(setq sgml-range-indicator-max-length 9) 



(add-hook 
 'sgml-mode-hook		; These only apply in sgml-mode  
 (function 
  (lambda() 


;; Mouse Bindings: right-click generates elements/attributes menu

    (define-key sgml-mode-map [mouse-3] 'sgml-tags-menu) 


;; Create "SGML Color Themes" submenu in the SGML menu

;; using easy-menu...
    (easy-menu-add-item
     sgml-main-menu nil
     '("SGML Color Themes" 
       ["Light" color-theme-sgml-light]
       ["Blue Low " color-theme-sgml-blue-lo]
       ["Blue High" color-theme-sgml-blue-hi]
       ["Green Low" color-theme-sgml-green-lo]
       ["Green High" color-theme-sgml-green-hi]
       ["Black Low" color-theme-sgml-black-lo]
       ["Black Low 2" color-theme-sgml-black-lo-2]
       ["Black High" color-theme-sgml-black-hi]
       ["Black High 2" color-theme-sgml-black-hi-2]
       ))
    
;; using simple menu items...	
;;     (defvar theme-menu (make-sparse-keymap "SGML Color Themes"))
;;
;;     (define-key theme-menu [green-theme-hi]
;;       '("Green High" . color-theme-sgml-green-hi))
;;     (define-key theme-menu [green-theme-lo]
;;       '("Green Low" . color-theme-sgml-green-lo))
;;     (define-key theme-menu [blue-theme-hi]
;;       '("Blue High" . color-theme-sgml-blue-hi))
;;     (define-key theme-menu [blue-theme-lo]
;;       '("Blue Low" . color-theme-sgml-blue-lo))
;;     (define-key theme-menu [light-theme]
;;       '("Light" . color-theme-sgml-light))
;;
;;     (define-key sgml-main-menu [themes]  ; place in SGML Menu
;;       (cons "SGML Color Themes" theme-menu))


;; ======
    ))) ;  	  
;; ======
;;; END Menu Config




;;; settings.el ends here
