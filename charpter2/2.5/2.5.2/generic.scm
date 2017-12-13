(load "put-and-get.scm")
(load "tag.scm")
(load "scheme-number-package.scm")
(load "rational-package.scm")
(load "complex-package.scm")

(define (level type)
  (cond ((eq? type 'scheme-number)
         0)
        ((eq? type 'rational)
         1)
        ((eq? type 'complex)
         2)
        (else
         (error "Invalid type: LEVEL" type))))

(define (highest-type args)
  (if (null? (cdr args))
      (type-tag (car args))
      (let ((t1 (type-tag (car args)))
            (t2 (highest-type (cdr args))))
        (let ((l1 (level t1))
              (l2 (level t2)))
          (if (> l1 l2)
              t1
              t2)))))

(define (raise-to-type type item)
  (let ((item-type (type-tag item)))
    (if (eq? item-type type)
        item
        (let ((raise-fn (get 'raise (list item-type))))
          (if raise-fn
              (raise-to-type type (raise-fn (contents item)))
              false)))))

(define (all-true? lst)
  (cond ((null? lst)
         true)
        ((car lst)
         (all-true? (cdr lst)))
        (else
         false)))

(define (raise-to-common args)
  (let ((raised-args (map (lambda (x)
                            (raise-to-type (highest-type args) x))
                          args)))
    (if (all-true? raised-args)
        raised-args
        false)))

(define (drop x)
  (let ((project-proc (get 'project (list (type-tag x)))))
    (if project-proc
        (let ((dropped (project-proc (contents x))))
          (if (equ? x (raise dropped))
              (drop dropped)
              x))
        x)))

(define (apply-generic op . args)
  (define (no-method type-tags)
    (error "No method for these types"
           (list op type-tags)))
  
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (> (length args)
                 1)
              (let ((raised-args (raise-to-common args)))
                (if raised-args
                    (let ((proc (get op (map type-tag raised-args))))
                      (if proc
                          (apply proc (map contents raised-args))
                          (no-method (map type-tag raised-args))))
                    (no-method map type-tag tags)))
              (no-method (map type-tag args)))))))

(define (add x y)
  (drop (apply-generic 'add x y)))

(define (sub x y)
  (drop (apply-generic 'sub x y)))

(define (mul x y)
  (drop (apply-generic 'mul x y)))

(define (div x y)
  (drop (apply-generic 'div x y)))

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

(define (raise x)
  (apply-generic 'raise x))

(define (project x)
  (apply-generic 'project x))

(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-rational-package)
(install-scheme-number-package)