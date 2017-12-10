(define (looup given-key tree-of-records)
  (if (null? tree-of-records)
      #f
      (let ((entry-key (key (entry tree-of-records))))
        (cond ((= given-key entry-key)
               (entry tree-of-records))
              ((< given-key entry-key)
               (loopup given-key (left-branch tree-of-records)))
              (else
               (loopup given-key (right-branch tree-of-records)))))))