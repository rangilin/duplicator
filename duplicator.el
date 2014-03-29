;;; duplicator.el --- duplicate texts in Emacs

;; Copyright (C) 2014 Rangi Lin

;; Author: Rangi Lin <rangiltw at google mail>
;; Version: 0.2.1

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Duplicator is a small package that help you duplicate lines.
;;
;; 1. Duplicate current line if no region is active
;; 2. Duplicate all lines in the region if region is active
;; 3. Support prefix argument to execute multiple times
;; 4. Never pollute kill ring

;; ## Usage:
;;
;; (require 'duplicator)
;; (global-set-key (kbd "C-c d") 'duplicator/duplicate-lines)

;; ## Limitations:
;; enable transient-mark-mode is required

;;; Code:

(defun duplicator/duplicate-lines (n)
  "Duplicate lines. If region is not active, duplicate current line, otherwise
duplicate whole lines across the region. Execute n time if prefix argument is
given."
  (interactive "p")
  (if (region-active-p)
      (duplicator--duplicate-whole-lines-in-region n)
    (duplicator--duplicate-current-line n)))

(defun duplicator--duplicate-whole-lines-in-region (n)
  "Duplicate whole lines across the current region N times"
  (let* ((pair (duplicator--whole-line-point-pair))
         (start (car pair))
         (end (cdr pair))
         (lines (duplicator--add-trailing-newline
                 (substring-no-properties (filter-buffer-substring start end))))
         (column (current-column)))
    (goto-char start)
    (dotimes (time (or n 1))
      (insert lines))
    (move-to-column column)))

(defun duplicator--duplicate-current-line (n)
  "Duplicate current lines N times"
  (let ((current-line (duplicator--add-trailing-newline
                       (substring-no-properties (thing-at-point 'line))))
        (column (current-column)))
    (beginning-of-line)
    (dotimes (time (or n 1))
      (insert current-line))
    (move-to-column column)))

(defun duplicator--add-trailing-newline (string)
  "Return string with a leading newline character"
  (if (string-match "\n$" string)
      string
    (concat string "\n")))

(defun duplicator--whole-line-point-pair ()
  "Return a cons cell according to current point and mark position. First argument of cons
cell is point of beginning of the line where region starts, second argument is the point
 of end of the line where region ends"
  (let ((num-of-lines (count-lines (point) (mark))))
    (cond
     ((< (point) (mark)) (cons (line-beginning-position) (line-end-position num-of-lines)))
     ((> (point) (mark)) (cons (line-beginning-position (- 1 (1- num-of-lines))) (line-end-position)))
     (t (cons (line-beginning-position) (line-end-position))))))

(provide 'duplicator)
;;; duplicator.el ends here
