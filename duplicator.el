;;; duplicator.el --- duplicate texts in Emacs

;; Copyright (C) 2014 Rangi Lin

;; Author: Rangi Lin <rangiltw at google mail>
;; Version: 0.1.0

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
;; 1. It never pollute kill ring
;; 2. It duplicate whole lines across region even if region didn't cover all

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
  (dotimes (time (or n 1))
    (if (region-active-p)
        (duplicator--duplicate-whole-lines-in-region)
      (duplicator--duplicate-current-line))))

(defun duplicator--duplicate-whole-lines-in-region ()
  "Duplicate whole lines across the current region"
  (let* ((pair (duplicator--whole-line-point-pair))
         (start (car pair))
         (end (cdr pair))
         (lines (substring-no-properties (filter-buffer-substring start end)))
         (column (current-column)))
    (goto-char start)
    (insert (duplicator--add-trailing-newline lines))
    (move-to-column column)))

(defun duplicator--duplicate-current-line ()
  "Duplicate current lines"
  (let ((current-line (substring-no-properties (thing-at-point 'line)))
        (column (current-column)))
    (beginning-of-line)
    (insert (duplicator--add-trailing-newline current-line))
    (move-to-column column)))

(defun duplicator--add-trailing-newline (string)
  "Return string with a leading newline character"
  (if (string-match "\n$" string)
      string
    (concat string "\n")))

(defun duplicator--whole-line-point-pair ()
  "Return a cons cell according to given point and mark position. First argument is point
of beginning of the line where region starts, second argument is the point of end of the
line where region ends"
  (let ((num-of-lines (count-lines (point) (mark))))
    (cond
     ((< (point) (mark)) (cons (line-beginning-position) (line-end-position num-of-lines)))
     ((> (point) (mark)) (cons (line-beginning-position (- (- num-of-lines 1))) (line-end-position)))
     (t (cons (line-beginning-position) (line-end-position))))))

(provide 'duplicator)
;;; duplicator.el ends here
