(load "order-set.scm")
(load "2.62.scm")

(define (adjoin-set x set)
  (union-set (list x) set))