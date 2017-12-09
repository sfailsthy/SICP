(define (deep-reverse tree)
  (define (iter items result)
    (if (null? items)
        result
        (iter (cdr items)
              (cons (if (pair? (car items))
                        (deep-reverse (car items))
                        (car items))
                    result))))

  (iter tree '()))