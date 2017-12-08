(load "1.43.iteration.scm")
(load "average-damp.scm")

(define (expt base n)
  (if (= n 0)
      1
      ((repeated (lambda (x) (* base x)) n) 1)))

(define (average-damp-n-times f n)
  ((repeated average-damp n) f))

(define (damped-nth-root n damp-times)
  (lambda (x)
    (fixed-point (average-damp-n-times (lambda (y) (/ x (expt y (- n 1))))
                                       damp-times)
                 1.0)))

(define (lg n)
  (cond ((> (/ n 2) 1)
         (+ 1 (lg (/ n 2))))
        ((< (/ n 2) 1)
         0)
        (else 1)))

(define (nth-root n)
  (damped-nth-root n (lg n)))
