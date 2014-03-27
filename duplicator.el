;;; duplicator.el --- duplicate texts in Emacs

;; Copyright (C) 2014 Rangi Lin

;; Author: Rangi Lin <rangiltw at google mail>
;; Version: 0.1.0

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
  "Duplicate lines. If region is not active, duplicate current line,
otherwise duplicate all lines across the region."
  (interactive)
  (let ((line (duplicator--add-trailing-newline (substring-no-properties (thing-at-point 'line))))
        (column (current-column)))
    (beginning-of-line)
    (insert line)
    (move-to-column column)))

(defun duplicator--add-trailing-newline (string)
  "Return string with a leading newline character"
  (if (string-match "\n$" string)
      string
    (concat string "\n")))

(provide 'duplicator)
;;; duplicator.el ends here
