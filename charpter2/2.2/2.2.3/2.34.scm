(load "accumulate.scm")

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-term)
                (+ this-coeff
                   (* x higher-term)))
              0
              coefficient-sequence))