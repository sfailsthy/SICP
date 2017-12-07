#lang scheme
(define (cont-frac n d k)
  (define (cf i)
    (if (= i k)
        (/ (n k)
           (d k))
        (/ (n i)
           (+ (d i)
              (cf (+ i 1))))))
  (cf 1))

(define (golden-ratio k)
  (+ 1
     (cont-frac (lambda (i) 1.0)
                (lambda (i) 1.0)
                k)))