(define (split combiner1 combiner2)
  (lambda (paint n)
    (if (= n 0)
        painter
        (let ((smaller ((split combiner1 combiner2) painter (- n 1))))
          (combiner1 painter (combiner2 smaller smaller))))))