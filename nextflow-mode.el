;;; nextflow-mode.el --- Nextflow editing mode -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:
(require 'prog-mode)

(defgroup nextflow nil
  "Group for Nextflow."
  :prefix "nextflow-")

(defconst nextflow--assignment-regexp
  "\\s-*\\([[:word:]]+\\)\\s-*=\\(?:[^>=]\\)")

(defconst nextflow--boolean-regexp
  (concat "\\(?:^\\|[^.]\\)"
          (regexp-opt '("true" "false" "on" "off" "yes" "no")
                      'words)))

(defconst nextflow--map-regexp
  "\\(process\\|workflow\\) \\([[:word:]]+\\)\\s-*{")

(defconst nextflow--string-interpolation-regexp
  "\\${[^}\n\\\\]*\\(?:\\\\.[^}\n\\\\]*\\)*}")

(defconst nextflow--builtins-regexp
  "\\(process\\|workflow\\|input\\|output\\).*")

(defvar nextflow-font-lock-keywords
  `((,nextflow--assignment-regexp 2 font-lock-variable-name-face)
    (,nextflow--boolean-regexp . font-lock-constant-face)
    (,nextflow--map-regexp 1 font-lock-type-face)
    (,nextflow--string-interpolation-regexp 0 font-lock-variable-name-face t)
    (,nextflow--builtins-regexp 1 font-lock-builtin-face)))


;;;###autoload
(define-derived-mode nextflow-mode prog-mode "Nextflow"
  "Major mode for working with Nextflow files."
  :group 'nextflow-group

  (setq font-lock-defaults '((nextflow-font-lock-keywords))))


;;;###autoload
(add-to-list 'auto-mode-alist '("\\.nf\\'" . nextflow-mode))

(provide 'nextflow-mode)

;;; nextflow-mode.el ends here
