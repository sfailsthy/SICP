(load "put-and-get.scm")
(load "tag.scm")

(define (install-rational-package)
  ;internal procedures
  (define (numer x)
    (car x))

  (define (denom x)
    (cdr x))

  (define (add-rat x y)
    (make-rat (add (mul (numer x) (denom y))
                   (mul (numer y) (denom x)))
              (mul (denom x) (denom y))))

  (define (sub-rat x y)
    (make-rat (sub (mul (numer x) (denom y))
                   (mul (numer y) (denom x)))
              (mul (denom x) (denom y))))

  (define (mul-rat x y)
    (make-rat (mul (numer x) (numer y))
              (mul (denom x) (denom y))))

  (define (div-rat x y)
    (make-rat (mul (numer x) (denom y))
              (mul (denom x) (numer y))))
  
  (define (make-rat n d)
    (let* ((result (reduce n d))
           (x (car result))
           (y (cadr result)))
      (if (less0? y)
          (cons (negate x)
                (negate y))
          (cons x y))))
            
  ;interface to the rest of the system
  (define (tag x)
    (attach-tag 'rational x))

  (put 'add '(rational rational)
       (lambda (x y)
         (tag (add-rat x y))))

  (put 'sub '(rational rational)
       (lambda (x y)
         (tag (sub-rat x y))))

  (put 'mul '(rational rational)
       (lambda (x y)
         (tag (mul-rat x y))))

  (put 'div '(rational rational)
       (lambda (x y)
         (tag (div-rat x y))))

  (put 'equ? '(rational rational)
       (lambda (x y)
         (and (= (numer x)
                 (numer y))
              (= (denom x)
                 (denom y)))))

  (put '=zero? '(rational)
       (lambda (x)
         (= (numer x) 0)))

  (put 'less0? '(rational)
       (lambda (x)
         (less0? (div (numer x)
                      (denom x)))))
  
  (put 'negate '(rational)
       (lambda (x)
         (make-rational (- (numer x))
                        (denom x))))

  (define (rational->complex r)
    (make-complex-from-real-imag (exact->inexact (/ (numer r)
                                                    (denom r)))
                                 0))

  (put 'raise '(rational)
       (lambda (r) (rational->complex r)))

  (put 'project '(rational)
       (lambda (r)
         (make-scheme-number (floor (/ (numer r)
                                       (denom r))))))
  
  (put 'make 'rational
       (lambda (n d)
         (tag (make-rat n d))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))