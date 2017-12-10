(load "2.40.scm")

(define (unique-triples n)
  (flatmap (lambda (i)
             (map (lambda (j)
                    (cons i j))
                  (unique-pairs (- i 1))))
           (enumerate-interval 1 n)))

(define (triple-sum-equal? sum triple)
  (= sum
     (+ (car triple)
        (cadr triple)
        (caddr triple))))

(define (triple-sum-equal-s s n)
  (filter (lambda (triple)
            (triple-sum-equal? s triple))
          (unique-triples n)))
