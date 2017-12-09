(define (reverse lst)
  (iter lst '()))

(define (iter items result)
  (if (null? items)
      result
      (iter (cdr items)
            (cons (car items)
                  result))))