(load "scale-stream.scm")
(load "3.55.scm")
(load "display-stream.scm")

(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1))
                4))