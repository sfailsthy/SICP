(define (carmichael-test n)
  (test-iter 1 n))

(define (test-iter a n)
  (cond ((= a n)
         true)
        ((congruent? a n)
         (test-iter (+ a 1) n))
        (else
         false)))

(define (congruent? a n)
  (= (expmod a n n) a))

(define (expmod base exp m)
  (cond ((= exp 0)
         1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (square x)
  (* x x))