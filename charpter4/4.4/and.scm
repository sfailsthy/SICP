(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
      frame-stream
      (conjoin (rest-conjuncts conjuncts)
               (qeval (first-conjuncts conjuncts)
                      frame-stream))))

(put 'and 'qeval conjoin)