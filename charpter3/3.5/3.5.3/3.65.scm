(load "3.55.scm")
(load "euler-transform.scm")
(load "accelerated-sequence.scm")

(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln2-summands (+ n 1)))))

(define ln2-stream
  (partial-sums (ln2-summands 1)))

(define x ln2-stream)

(define y (euler-transform x))

(define z (accelerated-sequence euler-transform x))