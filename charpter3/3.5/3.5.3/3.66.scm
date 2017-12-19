(define (stream-take-while pred? stream)
  (if (stream-null? stream)
      the-empty-stream
      (if (pred? (stream-car stream))
          (cons-stream (stream-car stream)
                       (stream-take-while pred? (stream-cdr stream)))
          the-empty-stream)))