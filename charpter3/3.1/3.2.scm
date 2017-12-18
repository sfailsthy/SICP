(define (make-monitored f)
  (let ((count 0))
    (lambda (input)
      (cond ((eq? input 'how-many-calls?)
             count)
            ((eq? input 'reset-count)
             (begin
               (set! count 0)
               count))
            (else
             (begin
               (set! count (+ 1 count))
               (f input)))))))