(define dx 0.00001)

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))

(define (smooth-n-times f n)
  ((repeated smooth n) f))

(define (repeated f n)
  (define (iter i result)
    (if (= i 1)
        result
        (iter (- i 1)
              (compose f result))))

  (iter n f))

(define (compose f g)
  (lambda (x)
    (f (g x))))