
;;

(add-hook 'org-mode-hook 'org-indent-mode)

(use-package org-tidy
  :ensure t
  :config
  (add-hook 'org-mode-hook #'org-tidy-mode))
;; (require 'ox-taskjuggler)

(provide 'setup-org)
