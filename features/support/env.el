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

(Setup
 ;; Before anything has run
 )

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
