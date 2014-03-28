;; This file contains your project specific step definitions. All
;; files in this directory whose names end with "-steps.el" will be
;; loaded automatically by Ecukes.

(Given "^Kill ring is empty$"
       (lambda ()
         (setq kill-ring nil)))

(Given "^I copy current region$"
       (lambda ()
         (kill-ring-save (region-beginning) (region-end))
         (deactivate-mark)))

(Then "^Kill ring should contains \\([0-9]+\\) records"
      (lambda (num)
        (let ((actual (length kill-ring)))
          (assert (eq (string-to-number num) actual) nil
                  "Exception kill ring contains %s records, but was %s" num actual))))
