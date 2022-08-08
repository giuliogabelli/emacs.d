;;; vhdl-tools-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "vhdl-tools" "vhdl-tools.el" (0 0 0 0))
;;; Generated autoloads from vhdl-tools.el

(add-to-list 'auto-mode-alist '("\\.vhd" . vhdl-tools-mode))

(autoload 'vhdl-tools-mode "vhdl-tools" "\
Utilities for navigating vhdl sources.

Key bindings:
\\{vhdl-tools-mode-map}

\(fn)" t nil)

(autoload 'vhdl-tools-vorg-mode "vhdl-tools" "\
Utilities for navigating vhdl sources in vorg files.

Key bindings:
\\{vhdl-tools-vorg-mode-map}

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vhdl-tools" '("vhdl-tools-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; vhdl-tools-autoloads.el ends here
