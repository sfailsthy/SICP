(load "put-and-get.scm")
(load "tag.scm")

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))

  (define (integer->rational n)
    (make-rational n 1))

  (put 'raise '(scheme-number)
       (lambda (i)
         (integer->rational i)))
  
  (define (reduce-integers n d)
    (let ((g (gcd n d)))
      (list (/ n g)
            (/ d g))))

  (put 'reduce '(scheme-number scheme-number)
       (lambda (n d)
         (reduce-integers n d)))
  
  (put 'greatest-common-divisor '(scheme-number scheme-number)
       (lambda (x y)
         (tag (gcd x y))))
  
  (put 'add '(scheme-number scheme-number)
       (lambda (x y)
         (tag (+ x y))))

  (put 'sub '(scheme-number scheme-number)
       (lambda (x y)
         (tag (- x y))))

  (put 'mul '(scheme-number scheme-number)
       (lambda (x y)
         (tag (* x y))))

  (put 'div '(scheme-number scheme-number)
       (lambda (x y)
         (tag (/ x y))))

  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y)
         (= x y)))

  (put '=zero? '(scheme-number)
       (lambda (x)
         (= x 0)))
  (put 'less0? '(scheme-number)
       (lambda (x)
         (< x 0)))
  
  (put 'negate '(scheme-number)
       (lambda (x)
         (tag (- x))))
  
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))