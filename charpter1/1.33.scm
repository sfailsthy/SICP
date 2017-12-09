(load "prime.scm")
(load "gcd.scm")

(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (cond ((> a b)
           result)
          ((filter (term a))
           (iter (next a) (combiner (term a)
                                    result)))
          (else
           (iter (next a) result))))
  (iter a null-value))

(define (primes-sum a b)
  (filtered-accumulate prime? + 0 (lambda (x) x) a (lambda (x) (+ x 1)) b))

(define (product-of-coprime n)
  (define (coprime? i)
    (and (< i n)
       (= 1 (gcd i n))))
  (filtered-accumulate coprime? * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) n))