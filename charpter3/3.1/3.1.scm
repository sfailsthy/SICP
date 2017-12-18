(define (make-accumulator value)
  (lambda (add-value)
    (set! value (+ add-value value))
    value))
    