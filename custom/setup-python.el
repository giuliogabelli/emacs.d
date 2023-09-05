(use-package jedi)

;; FIXME!
;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)

(defun elpy-goto-definition-or-rgrep ()
  "Go to the definition of the symbol at point, if found. Otherwise, run `elpy-rgrep-symbol'."
  (interactive)
  (ring-insert find-tag-marker-ring (point-marker))
  (condition-case nil (elpy-goto-definition)
    (error (elpy-rgrep-symbol
            (concat "\\(def\\|class\\)\s" (thing-at-point 'symbol) "(")))))

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  (define-key elpy-mode-map (kbd "M-.") 'elpy-goto-definition-or-rgrep)
  ;;(setq elpy-rpc-backend "jedi"))
  )


(provide 'setup-python)
