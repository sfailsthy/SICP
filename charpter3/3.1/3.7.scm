(load "3.3.scm")

(define (make-joint acc acc-pass new-pass)
  (define (dispatch password m)
    (if (eq? password new-pass)
        (acc acc-pass m)
        (error "Bad joint password -- " password)))
  dispatch)