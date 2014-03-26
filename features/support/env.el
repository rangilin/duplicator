(require 'f)

(defvar duplicator-support-path
  (f-dirname load-file-name))

(defvar duplicator-features-path
  (f-parent duplicator-support-path))

(defvar duplicator-root-path
  (f-parent duplicator-features-path))

(add-to-list 'load-path duplicator-root-path)

(require 'duplicator)
(require 'espuds)
(require 'ert)

(Before
 (global-set-key (kbd "C-c d") 'duplicator/duplicate-lines)
 (transient-mark-mode 1)
 (switch-to-buffer
  (get-buffer-create "*duplicator*"))
 (erase-buffer))
