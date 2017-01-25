;; setup the colors
;; we should check to see if we have a color or b/w display maybe?
(setq default-major-mode 'text-mode)
(setq tab-stop-list 4)
(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color     "white")
(set-mouse-color      "yellow")
(set-border-color     "black")
;; modeline colors
(set-face-foreground 'modeline "black")
(set-face-background 'modeline "white")

(setq mode-line-format "--%1*%1*-Emacs: %17b   %M   %[(%m)%]--%c:%l--%3p--%-")


