(define (for-each p lst)
  (cond ((not (null? lst))
         (p (car lst))
         (for-each p (cdr lst)))))