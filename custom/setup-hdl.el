;;

(require 'vhdl-mode)

;;;
;;; VHDL Mode
;;;
(use-package vhdl-tools)
(autoload 'vhdl-mode "vhdl-mode" "VHDL Mode" t)

(setq auto-mode-alist (cons '("\\.vhdl?$" . vhdl-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.do?$" . tcl-mode) auto-mode-alist))

;;;
;;; Miscellaneous customizations
;;;

(with-eval-after-load 'vhdl-mode
                                        ;		  (add-to-list 'load-path "...")
  (require 'vhdl-tools))

(add-hook 'vhdl-mode-hook
          (lambda ()
            (vhdl-tools-mode 1)))

(add-to-list 'auto-mode-alist '("\\.xdc\\'" . tcl-mode))

(define-key vhdl-mode-map (kbd "SPC") nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(flycheck-define-checker vhdl-tool
  "A VHDL syntax checker, type checker and linter using VHDL-Tool.

See URL `http://vhdltool.com'."
  :command ("vhdl-tool" "client" "lint" "--compact" "--stdin" "-f" source
            )
  :standard-input t
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ":w:" (message) line-end)
   (error line-start (file-name) ":" line ":" column ":e:" (message) line-end))
  :modes (vhdl-mode))

(add-to-list 'flycheck-checkers 'vhdl-tool)

;(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)



(defun my-verilog-up-ifdef ()
  "Go up `ifdef/`ifndef/`else/`endif macros until an enclosing one is found."
  (interactive)
  (let ((pos (point)) (depth 0) done)
    (while (and (not done)
                (re-search-backward "^\\s-*`\\(ifdef\\|ifndef\\|endif\\)" nil t))
      (if (looking-at "\\s-*`endif")
          (setq depth (1+ depth))
        (if (= depth 0)
            (setq done t)
          (when (looking-at "\\s-*`if")
              (setq depth (1- depth))))))
    (unless done
      (goto-char pos)
      (error "Not inside an `ifdef construct"))))



(defun my-verilog-down-ifdef ()
  "Go up `ifdef/`ifndef/`else/`endif macros until an enclosing one is found."
  (interactive)
  (let ((pos (point)) (depth 0) done)
    (while (and (not done)
                (re-search-forward "^\\s-*`\\(ifdef\\|ifndef\\|endif\\)" nil t))
      (progn ; Lets you evaluate more than one sexp for the true case
        (re-search-backward "^\\s-*`\\(ifdef\\|ifndef\\|endif\\)")
        (if (looking-at "\\s-*`if")
              (setq depth (1+ depth))
          (if (= depth 0)
              (setq done t)
            (when (looking-at "\\s-*`endif")
                (setq depth (1- depth))))))
        (re-search-forward "^\\s-*`\\(ifdef\\|ifndef\\|else\\|endif\\)" nil t))
    (unless done
      (goto-char pos)
      (error "Not inside an `ifdef construct"))))




(while (re-search-forward "^\\s-*`\\(ifdef\\|ifndef\\|else\\|endif\\)" nil t)
  (progn ; Lets you evaluate more than one sexp for the true case
    (re-search-backward "^\\s-*`\\(ifdef\\|ifndef\\|else\\|endif\\)")
    (warning "Not inside an `ifdef construct")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cl)

(use-package veri-kompass)
(require 'veri-kompass)

;(add-to-list 'load-path "path-to-veri-kompass-here")


(add-hook 'verilog-mode-hook 'veri-kompass-minor-mode)

(setq verilog-tool 'verilog-linter)
(setq verilog-linter "verilator --lint-only")

(provide 'setup-hdl)

;;;
