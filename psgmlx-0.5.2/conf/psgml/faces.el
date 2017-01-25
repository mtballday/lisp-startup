;;; faces.el --- make faces for sgml mode

;; $Id: faces.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.


;;; Commentary:

;; Don't edit this file unless you know what you're doing



;;; Code:

(setq-default sgml-set-face t)		; Make highlighting possible


(make-face 'sgml-comment-face)		; Use all faces defined by PSGML
(make-face 'sgml-doctype-face)
(make-face 'sgml-end-tag-face)
(make-face 'sgml-entity-face)
(make-face 'sgml-ignored-face)
(make-face 'sgml-ms-end-face)
(make-face 'sgml-ms-start-face)
(make-face 'sgml-pi-face)
(make-face 'sgml-sgml-face)
(make-face 'sgml-short-ref-face)
(make-face 'sgml-start-tag-face)

(setq-default 
 sgml-markup-faces '(
		     (comment . sgml-comment-face)
		     (doctype . sgml-doctype-face)
		     (end-tag . sgml-end-tag-face)
		     (entity . sgml-entity-face)
		     (ignored . sgml-ignored-face)
		     (ms-end . sgml-ms-end-face)
		     (ms-start . sgml-ms-start-face)
		     (pi . sgml-pi-face)
		     (sgml . sgml-sgml-face)
		     (short-ref . sgml-short-ref-face)
		     (start-tag . sgml-start-tag-face)
		     ))



;; No need to edit the following, unless you DON'T use color-theme
;; (They are set in color-theme-sgmlgreen, sgmlblue, and sgmllight)

;; --  Most Common Faces  --

;; Dark Backgrounds
;   (set-face-foreground 'sgml-start-tag-face "DeepSkyBlue")
;   (set-face-foreground 'sgml-end-tag-face "SeaGreen2") 
;   (set-face-foreground 'sgml-doctype-face "salmon")
;   (set-face-foreground 'sgml-pi-face "lime green")
;   (set-face-foreground 'sgml-entity-face "magenta")

;; Light Backgrounds
;   (set-face-foreground 'sgml-start-tag-face "blue2") 
;   (set-face-foreground 'sgml-end-tag-face "green4")
;   (set-face-foreground 'sgml-doctype-face "brown")
;   (set-face-foreground 'sgml-pi-face "OrangeRed")
;   (set-face-foreground 'sgml-entity-face "DarkOrchid1")

;; --  Less Common faces --  

;; (set-face-foreground 'sgml-ignored-face "gray50")
;; (set-face-background 'sgml-ignored-face "gray60")
;; (set-face-foreground 'sgml-ms-end-face "green")
;; (set-face-foreground 'sgml-ms-start-face "DarkGoldenRod")
;; (set-face-foreground 'sgml-sgml-face "brown")
;; (set-face-foreground 'sgml-short-ref-face "DeepSkyBlue")


;;; faces.el ends here
