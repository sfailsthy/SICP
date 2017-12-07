#lang scheme
(define (repeated f n)
  (define (iter i result)
    (if (= i 1)
        result
        (iter (- i 1)
              (compose f result))))

  (iter n f))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (square x)
  (* x x))

((repeated square 2) 5)