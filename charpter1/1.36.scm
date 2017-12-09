(define tolerance 0.000001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))

  (define (try guess step)
    (display-info guess step)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          (begin
            (display-info next (+ step 1))
            next)
          (try next (+ step 1)))))
  
  (try first-guess 1))

(define (display-info guess step)
  (display "step : ")
  (display step)
  (display " ")

  (display "guess : ")
  (display guess)
  (newline))

(define formula
  (lambda (x)
    (/ (log 1000)
       (log x))))