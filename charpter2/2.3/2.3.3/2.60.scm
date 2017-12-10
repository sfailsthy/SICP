(define (element-of-set? x set)
  (cond ((null? set)
         false)
        ((equal? x (car set))
         true)
        (else
         (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (append set1 set2))

(define (intersection-set set1 set2)
  (define (iter set result)
    (if (or (null? set)
            (null? set2))
        (reverse result)
        (let ((current (car set))
              (remain (cdr set)))
          (if (and (element-of-set? current set2)
                   (not (element-of-set? current result)))
              (iter remain (cons current result))
              (iter remain result)))))
  (iter set1 '()))