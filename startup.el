(if (file-accessible-directory-p "$HOME/lisp-startup")
    (setq load-path (cons (expand-file-name "$HOME/lisp-startup")
			  load-path)))

(defun byte-compile-if-newer-and-load (file)
  "Byte compile file.el if newer than file.elc"
  (if (file-newer-than-file-p (concat file ".el")
			      (concat file ".elc"))
      (byte-compile-file (concat file ".el")))
  (load file))

(byte-compile-if-newer-and-load "$HOME/lisp-startup/toggle-source")
(byte-compile-if-newer-and-load "$HOME/lisp-startup/line-num")
(byte-compile-if-newer-and-load "$HOME/lisp-startup/matlab")
(byte-compile-if-newer-and-load "$HOME/lisp-startup/outline-magic")
(byte-compile-if-newer-and-load "$HOME/lisp-startup/doc-mode-1.1/doc-mode.el")
(byte-compile-if-newer-and-load "$HOME/lisp-startup/csv-mode")
(byte-compile-if-newer-and-load "$HOME/lisp-startup/org-outlook")
(byte-compile-if-newer-and-load "$HOME/lisp-startup/graphviz-dot-mode")
(byte-compile-if-newer-and-load "$HOME/lisp-startup/markdown-mode.el")

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)



(setq-default ispell-program-name "aspell")


(require 'org-outlook)

(global-set-key "\C-cr"     'revert-buffer)

 (add-hook 'outline-mode-hook 
           (lambda () 
             (require 'outline-magic)))
             
 (add-hook 'outline-minor-mode-hook 
           (lambda () 
             (require 'outline-magic)
             (define-key outline-minor-mode-map [(f10)] 'outline-cycle)))

; Renumber-list command
(defun renumber-list (start end &optional num)
      "Renumber the list items in the current START..END region.
    If optional prefix arg NUM is given, start numbering from that number
    instead of 1."
      (interactive "*r\np")
      (save-excursion
        (goto-char start)
        (setq num (or num 1))
        (save-match-data
          (while (re-search-forward "^[0-9]+" end t)
            (replace-match (number-to-string num))
            (setq num (1+ num))))))

;; setup the colors
;; we should check to see if we have a color or b/w display maybe?
(setq default-major-mode 'indented-text-mode)
(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color     "white")
(set-mouse-color      "yellow")
(set-border-color     "black")
;; modeline colors
;;(set-face-foreground 'modeline "black")
;;(set-face-background 'modeline "white")

(line-number-mode t)
(display-time)
(setq display-time-day-and-date t)
(auto-save-mode t)
(setq-default fill-column 80)
(setq next-line-add-newlines nil)

(setq mode-line-format "--%1*%1*-Emacs: %17b   %M   %[(%m)%]--%c:%l--%3p--%-")

; Various Key bindings.
(global-set-key "\C-cr"     'revert-buffer)
(global-set-key "\C-c\C-v"  'scroll-down)
(global-set-key "\C-c \C-c" 'clipboard-kill-ring-save)
(global-set-key "\C-ci"     'ispell-word)
(global-set-key "\C-c\C-i"  'ispell-buffer)
(global-set-key "\C-c\C-r"  'replace-regexp)
;(global-set-key "\C-x\C-a"  'auto-fill-mode)
(global-set-key "\C-c\C-g"  'goto-line)
;(global-set-key "\C-c\C-m"  'compile)
(global-set-key "\C-ck" '(lambda (&optional arg) "kill lines without kill."
			   (interactive "p") 
			   (save-excursion 
			     (copy-region-as-kill 
			      (point) 
                              (progn 
                                (forward-line (or arg 1))
                                (1- (point)))))))

(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode    "cc-mode" "C Editing Mode" t)
(autoload 'objc-mode "cc-mode" "Objective-C Editing Mode" t)
(setq auto-mode-alist
  (append '(("\\.C$"        . c++-mode)
            ("\\.cc$"       . c++-mode)
            ("\\.c$"        . c++-mode)
            ("\\.h$"        . c++-mode)
            ("\\.m$"        . matlab-mode)
            ("\\.java$"        . java-mode)
            ("\\.cs"            . csharp-mode)
	    ("\\.adb$"      . ada-mode)
	    ("\\.ads$"      . ada-mode)
	    ("\\.pl$"       . perl-mode)
	    ("[Mm]akefile$" . makefile-mode)
	    ("\\.emacs$"    . emacs-lisp-mode)
	    ("\\.out$"    . outline-mode)
	     ) auto-mode-alist))

;; enable various minor modes on startup
(defun enable-minor-modes ()
  "Enables all the minor modes that I like to use."
  (interactive "")
  (auto-fill-mode t)           ; word wrap            
  (abbrev-mode t)              ; abbreviation completion
  (auto-save-mode t))          ; pretty obvious, no?

(add-hook 'text-mode-hook          'enable-minor-modes)
(add-hook 'indented-text-mode-hook 'enable-minor-modes)
(add-hook 'c-mode-common-hook      'enable-minor-modes)
(add-hook 'emacs-lisp-mode-hook    'enable-minor-modes)
(add-hook 'dired-mode-hook         'enable-minor-modes)
(add-hook 'compilation-mode-hook   'enable-minor-modes)
(add-hook 'makefile-mode-hook      'enable-minor-modes)
(add-hook 'ada-mode-hook           'enable-minor-modes)
(add-hook 'outline-mode-hook       'enable-minor-modes)
(add-hook 'java-mode-hook          'enable-minor-modes)
(add-hook 'java-mode-hook (lambda() (local-set-key [tab] 'indent-according-to-mode)))
(add-hook 'java-mode-hook (lambda() (setq indent-tabs-mode nil)))

(add-hook 'c++-mode-hook (lambda() (local-set-key [tab] 'indent-according-to-mode)))
(add-hook 'c++-mode-hook (lambda() (setq indent-tabs-mode nil)))
(add-hook 'c++-mode-hook (lambda() (setq c-basic-offset 2)))


;; save and compile
(defun save-and-compile ()
  "Save current buffer and issue compile command."
  (interactive "")
  (save-buffer 0)
  (compile "make -k"))
(global-set-key "\C-cm"  'save-and-compile)

(setq indent-tabs-mode nil)

(setq c-indent-level 2)
(setq c-continued-statement-offset 2)
(setq c-label-offset -2)

(setq tex-dvi-view-command "xdvi $1")
(add-hook 'html-mode-hook 'turn-on-font-lock)
(custom-set-variables
 '(tab-width 2))
(custom-set-faces)
;(set-default-font "-adobe-courier-medium-r-normal--*-80-*-*-m-*-iso8859-1")

(require 'toggle-source)
(require 'csv-mode)

(defalias 'convertquotes (read-kbd-macro
"M-% C-q 223 RET `` RET ! C-u C-SPC M-% C-q 224 RET '' RET ! C-u C-SPC M-% C-q 221 RET ' RET ! C-u C-SPC M-% C-q 222 RET ' RET ! C-u C-SPC M-% C-q 226 RET -- RET ! C-u C-SPC M-% C-q 227 RET -- RET !"))

(defalias 'pods (read-kbd-macro
"cp SPC -v SPC \" C-s / C-s RET C-SPC C-e M-w \" SPC \"/g/ C-y \" RET touch SPC \"/g/ C-y \" C-a C-n"))

(fset 'dos2unix
   [?\C-c ?\C-r ?\C-q ?\C-m ?$ return return])

(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
(add-to-list 'auto-mode-alist '("\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))


(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-i"  'hungry-tab-to-stop)
;(global-set-key "\C-cm"  'compile)
(global-set-key "\C-cr"  'revert-buffer)
;(global-set-key "\C-u" 'undo)

(global-font-lock-mode 1)
(setq-default indent-tabs-mode nil)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

; package-refresh-contents
; need to M-x package-install RET jedi RET
; and
; M-x package-install RET elpy RET
