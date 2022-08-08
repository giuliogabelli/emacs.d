(require 'ggtags)

(ggtags-mode 1)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode )
              (ggtags-mode 1))))

;; Don't consider ` (back quote) as part of `tag' when looking for a
;; Verilog macro definition
(defun ggtags-tag-at-point ()
  (pcase (funcall ggtags-bounds-of-tag-function)
    (`(,beg . ,end)
     (if (eq ?` (string-to-char (buffer-substring beg end)))
         ;; If `(buffer-substring beg end)' returns "`uvm_info" (for example),
         ;; discard the ` and return just "uvm_info"
         (buffer-substring (1+ beg) end)
       ;; else return the whole `(buffer-substring beg end)'
       (buffer-substring beg end)))))

(dolist (map (list ggtags-mode-map dired-mode-map))
  (define-key map (kbd "C-c g s") 'ggtags-find-other-symbol)
  (define-key map (kbd "C-c g h") 'ggtags-view-tag-history)
  (define-key map (kbd "C-c g r") 'ggtags-find-reference)
  (define-key map (kbd "C-c g f") 'ggtags-find-file)
  (define-key map (kbd "C-c g c") 'ggtags-create-tags)
  (define-key map (kbd "C-c g u") 'ggtags-update-tags)
  (define-key map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
  (define-key map (kbd "M-.") 'ggtags-find-tag-dwim)
  (define-key map (kbd "M-,") 'pop-tag-mark)
  (define-key map (kbd "C-c <") 'ggtags-prev-mark)
  (define-key map (kbd "C-c >") 'ggtags-next-mark))

;; prevents emacs from asking you every time if you want to reread that updated TAGS file.
(setq tags-revert-without-query t)

;; In most of the cases, TAGS files will be large (> 50MB). Increase the threshold to 40MB. Warning can be disabled completely by setting the value to nil.
(setq large-file-warning-threshold (* 50 1024 1024))

;; ctags-update
;; https://github.com/jixiuf/ctags-update
(use-package ctags-update
  :config
  ;; Auto update
  (setq ctags-update-delay-seconds (* 30 60)) ; every 1/2 hour

  ;; you need manually create TAGS in your project
  (setq ctags-update-prompt-create-tags nil)
  (ctags-global-auto-update-mode)
  )




                             ;if you want to update (create) TAGS manually
(autoload 'ctags-update "ctags-update" "update TAGS using ctags" t)
(global-set-key "\C-cE" 'ctags-update)

(provide 'setup-ggtags)
