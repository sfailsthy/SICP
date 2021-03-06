(load "put-and-get.scm")
(load "tag.scm")
(load "scheme-number-package.scm")
(load "rational-package.scm")
(load "complex-package.scm")
(load "polynomial-package.scm")

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types -- APPLY-GENERIC"
           (list op type-tags))))))

(define (add x y)
  (apply-generic 'add x y))

(define (sub x y)
  (apply-generic 'sub x y))

(define (mul x y)
  (apply-generic 'mul x y))

(define (div x y)
  (apply-generic 'div x y))

(define (equ? x y)
  (apply-generic 'equ? x y))

(define (=zero? x)
  (apply-generic '=zero? x))

(define (less0? x)
  (apply-generic 'less0? x))

(define (negate x)
  (apply-generic 'negate x))

(define (greatest-common-divisor x y)
  (apply-generic 'greatest-common-divisor x y))

(define (reduce n d)
  (apply-generic 'reduce n d))

(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-rational-package)
(install-scheme-number-package)
(install-polynomial-package)