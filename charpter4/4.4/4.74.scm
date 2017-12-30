(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))

(define (simple-flattedn stream)
  (stream-map stream-car
              (stream-filter (lambda (frame)
                               (not (stream-null? frame)))
                             stream)))