(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor)
            n)
         n)
        ((divides test-divisor n)
         test-divisor)
        (else
         (find-divisor n ((next test-divisor))))))

(define (next n)
  (if ((= n 2)
       3)
      (+ n 2)))

(define (divides a b)
  (= (remainder b a) 0))

(define (prime? n)
  (if (= n 1)
      false
      (= n (smallest-divisor n))))

(define (square x)
  (* x x))

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