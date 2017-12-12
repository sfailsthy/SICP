(define (attach-tag type-tag x y)
  (list type-tag x y))

(define (type-tag datum)
  (car datum))

(define (contents datum)
  (cdr datum))
