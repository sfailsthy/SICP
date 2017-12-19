(load "3.59.a.scm")
(load "scale-stream.scm")

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(define cosine-series
  (cons-stream 1
               (scale-stream (integrate-series sine-series) -1)))