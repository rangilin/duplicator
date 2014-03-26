;;; duplicator.el --- duplicate texts in Emacs

;; Copyright (C) 2014 Rangi Lin

;; Author: Rangi Lin <rangiltw@gmail.com>
;; Version: 0.0.0

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

;;

;;; Code:

(defun duplicator/duplicate-lines ()
  "Duplicate lines. If no region is active, duplicate current line"
  (interactive)
  (let ((line (duplicator--strip-end-newline (substring-no-properties (thing-at-point 'line))))
        (column (current-column)))
    (end-of-line)
    (newline)
    (insert line)
    (move-to-column column)))

(defun duplicator--strip-end-newline (str)
  "Remove trailing newline of string "
  (replace-regexp-in-string
   (rx (: (* (char "\n")) eos)) "" str))

(provide 'duplicator)
;;; duplicator.el ends here
