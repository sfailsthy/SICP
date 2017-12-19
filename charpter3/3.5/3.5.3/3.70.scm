(load "integers.scm")

(define (merge-weighted weight s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let* ((s1car (stream-car s1))
                (s1carw (weight s1car))
                (s2car (stream-car s2))
                (s2carw (weight s2car)))
           (cond ((<= s1carw s2carw)
                  (cons-stream s1car (merge-weighted weight (stream-cdr s1) s2)))
                 (else
                  (cons-stream s2car (merge-weighted weight (stream-cdr s2) s1))))))))

(define (weighted-pairs weight s t)
  (cons-stream (list (stream-car s)
                     (stream-car t))
               (merge-weighted weight (stream-map (lambda (x) (list (stream-car s) x))
                                                  (stream-cdr t))
                               (weighted-pairs weight (stream-cdr s) (stream-cdr t)))))

(define a (weighted-pairs (lambda (x)
                            (+ (car x)
                               (cadr x)))
                          integers
                          integers))

;x|y
(define (divide? x y)
  (= (remainder y x)
     0))

(define no-235-factors
  (stream-filter (lambda (x) (not (or (divide? 2 x)
                                      (divide? 3 x)
                                      (divide? 5 x))))
                 integers))

(define b (weighted-pairs (lambda (x)
                            (+ (* 2 (car x))
                               (* 3 (cadr x))
                               (* 5 (car x) (cadr x))))
                          no-235-factors
                          no-235-factors))