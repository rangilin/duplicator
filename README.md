duplicator
==========

Duplicator is a small package that help you duplicate lines.

1. It never pollute kill ring
2. It duplicate whole lines across region even if region didn't cover all

## Usage:
```lisp
(require 'duplicator)
(global-set-key (kbd "C-c d") 'duplicator/duplicate-lines)
```

## Limitations:
enable transient-mark-mode is required

## Change Log:

### 0.1.0
+ duplicate current lines/whole lines across region


## License:
Copyright (C) 2014 Rangi Lin

Author: Rangi Lin <rangiltw at google mail>
Version: 0.1.0

This file is not part of GNU Emacs.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
