(load "integers.scm")
(load "3.54.scm")

(define ones (cons-stream 1 ones))

(define (div-streams s1 s2)
  (stream-map / s1 s2))

(define (integrate-series s)
  (mul-streams s
               (div-streams ones integers)))