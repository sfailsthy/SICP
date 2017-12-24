(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp env)
  (let ((text (cadr exp)))
    (if (pair? text)
        (eval (make-lazy-list (cadr exp)) env)
        text)))

(define (make-lazy-list elems)
  (if (null? elems)
      (list 'quote '())
      (list 'cons
            (list 'quote (car elems))
            (make-lazy-list (cdr elems)))))