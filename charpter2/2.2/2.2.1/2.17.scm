(define (last-pair lst)
  (cond ((null? lst)
         (error "empty list"))
        ((null? (cdr lst))
         lst)
        (else
         (last-pair (cdr lst)))))