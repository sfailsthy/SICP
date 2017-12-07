#lang scheme
(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
        x
        (- (square x))))
  (define (d i)
    (- (* 2 i) 1.0))
  (cont-frac n d k))

(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1) (/ (n i)
                         (+ (d i)
                            result)))))

  (iter (- k 1)
        (/ (n k) (d k))))

(define (square x)
  (* x x))