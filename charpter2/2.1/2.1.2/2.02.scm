(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))


(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))


(define (midpoint-segment seg)
  (let ((s (start-segment seg))
        (e (end-segment seg)))
    (make-point (/ (+ (x-point s)
                      (x-point e))
                   2.0)
                (/ (+ (y-point s)
                      (y-point e))
                   2.0))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))