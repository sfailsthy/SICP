(define (deep-reverse tree)
  (cond ((null? tree)
         '())
        ((not (pair? tree))
         tree)
        (else
         (append (deep-reverse (cdr tree))
                 (list (deep-reverse (car tree)))))))