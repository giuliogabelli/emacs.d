;;; package --- setup-ansi.el

;;; Commentary:
;;; Utilities for transalting ANSI SGR

;;; Code:
(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(provide 'setup-ansi)

;;; setup-ansi.el ends here
