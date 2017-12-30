(define (single-stream? s)
  (and (not (stream-null? s))
       (stream-null? (stream-cdr s))))

(define (unique-query exps)
  (car exps))

(define (uniquely-asserted pattern frame-stream)
  (stream-flatmap (lambda (frame)
                    (let ((stream (qeval (unique-query pattern)
                                         (singleton-stream frame))))
                      (if (single-stream? stream)
                          stream
                          the-empty-stream)))
                  frame-stream))