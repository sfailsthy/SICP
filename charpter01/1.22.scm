(load "prime.scm")

(define (next-odd n)
  (if (odd? n)
      (+ n 2)
      (+ n 1)))

(define (continue-primes n count)
  (cond ((= count 0)
         (display " are primes."))
        ((prime? n)
         (display n)
         (newline)
         (continue-primes n (- count 1)))
        (else
         (continue-primes (+ n 1) count))))

(define (search-for-primes n)
  (let ((start-time (real-time-clock)))
    (continue-primes n 3)
    (- (real-time-clock) start-time)))