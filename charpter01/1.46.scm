(define (iterative-improve good-enough? improve)
  (lambda (first-guess)
    (define (try guess)
      (let ((next (improve guess)))
        (if (good-enough? guess next)
            next
            (try next))))

    (try first-guess)))

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (good-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  
  (define (improve guess)
    (f guess))
  
  ((iterative-improve good-enough? improve) first-guess))

(define (sqrt x)
  (define dx 0.00001)
  (define (good-enough? v1 v2)
    (< (abs (- v1 v2)) dx))

  (define (improve guess)
    (average guess (/ x guess)))

  (define (average x y)
    (/ (+ x y) 2))
  ((iterative-improve good-enough? improve) 1.0))