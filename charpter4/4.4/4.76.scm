(define (new-conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
      frame-stream
      (merge-frame-streams (qeval (first-conjunct conjuncts)
                          frame-stream)
                   (new-conjoin (rest-conjuncts conjuncts)
                                frame-stream))))

(define (merge-frame-streams stream1 stream2)
  (stream-flatmap (lambda (f1)
                    (stream-filter (lambda (f)
                                     (not (eq? f 'failed)))
                                   (stream-map (lambda (f2)
                                                 (merge-frames f1 f2))
                                               stream2)))
                  stream1))
  
(define (merge-frames frame1 frame2)
  (cond ((null? frame1)
         frame2)
        ((eq? frame2 'failed)
         failed)
        (else
         (let ((var (binding-variable (car frame1)))
               (val (binding-value (car frame1))))
           (let ((extension (extend-if-possible var val frame2)))
             (merge-frames (cdr frame1) extension))))))