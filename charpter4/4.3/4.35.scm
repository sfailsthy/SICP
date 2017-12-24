(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-betweem (+ low 1)
                               high)))