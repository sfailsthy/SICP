(load "put-and-get.scm")
(load "tag.scm")

(define (install-polynomial-package)
  ;internal procedures
  ;represent of poly
  (define (make-poly variable term-list)
    (cons variable term-list))

  (define (variable poly)
    (car poly))

  (define (term-list poly)
    (cdr poly))

  (define (variable? x)
    (symbol? x))

  (define (same-variable? v1 v2)
    (and (variable? v1)
         (variable? v2)
         (eq? v1 v2)))

  (define (=zero-poly? poly)
    (define (zero-terms? term-list)
      (or (empty-termlist? term-list)
          (and (=zero? (coeff (first-term term-list)))
               (zero-terms? (rest-terms term-list)))))
    (zero-terms? (term-list poly)))
  ;represent of terms and term-lists

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1)
                        (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1)
                        (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- MUL-POLY"
               (list p1 p2))))

  (define (div-poly p1 p2)
    (if (same-variable? (variable p1)
                        (variable p2))
        (let ((div-result (div-terms (term-list p1)
                                     (term-list p2))))
          (list (make-poly (variable p1) (car div-result))
                (make-poly (variable p2) (cadr div-result))))
        (error "Polys not in same var -- DIV-POLY"
               (list p1 p2))))

  (define (gcd-poly p1 p2)
    (if (same-variable? (variable p1)
                        (variable p2))
        (make-poly (variable p1)
                   (gcd-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- GCD-POLY"
               (list p1 p2))))

  (define (reduce-poly p1 p2)
    (if (same-variable? (variable p1)
                        (variable p2))
        (let ((result (reduce-terms (term-list p1)
                                    (term-list p2))))
          (list (make-poly (variable p1)
                           (car result))
                (make-poly (variable p2)
                           (cadr result))))
        (error "Polys not in same var -- REDUCE-POLY"
               (list p1 p2))))
  
  (define (negate-poly p)
    (make-polynomial (variable p)
                     (negate-terms (term-list p))))
  ;interface to the rest of system
  (define (tag p)
    (attach-tag 'polynomial p))

  (put 'add '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (add-poly p1 p2))))

  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (mul-poly p1 p2))))

  (put 'div '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (div-poly p1 p2))))

  (put 'greatest-common-divisor '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (gcd-poly p1 p2))))

  (put 'reduce '(polynomial polynomial)
       (lambda (p1 p2)
         (let ((result (reduce-poly p1 p2)))
           (list (tag (car result))
                 (tag (cadr result))))))
  
  (put 'make 'polynomial
       (lambda (var terms)
         (tag (make-poly var terms))))

  (put '=zero? '(polynomial)
       (lambda (poly)
         (=zero-poly? poly)))

  (put 'less0? '(polynomial)
       (lambda (poly)
         (less0? (coeff (first-term (term-list poly))))))
  
  (put 'negate '(polynomial)
       (lambda (p)
         (negate-poly p)))

  (put 'sub '(polynomial polynomial)
       (lambda (x y)
         (tag (add-poly x (contents (negate-poly y))))))
  'done)

(define (add-terms L1 L2)
  (cond ((empty-termlist? L1)
         L2)
        ((empty-termlist? L2)
         L1)
        (else
         (let ((t1 (first-term L1))
               (t2 (first-term L2)))
           (cond ((> (order t1)
                     (order t2))
                  (adjoin-term t1
                               (add-terms (rest-terms L1)
                                          L2)))
                 ((< (order t1)
                     (order t2))
                  (adjoin-term t2
                               (add-terms L1
                                          (rest-terms L2))))
                 (else
                  (adjoin-term (make-term (order t1)
                                          (add (coeff t1)
                                               (coeff t2)))
                               (add-terms (rest-terms L1)
                                          (rest-terms L2)))))))))

(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms (mul-term-by-all-terms (first-term L1)
                                        L2)
                 (mul-terms (rest-terms L1)
                            L2))))

(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
        (adjoin-term (make-term (+ (order t1)
                                   (order t2))
                                (mul (coeff t1)
                                     (coeff t2)))
                     (mul-term-by-all-terms t1
                                            (rest-terms L))))))

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2)
               (order t1))
            (list (the-empty-termlist) L1)
            (let* ((new-c (div (coeff t1)
                               (coeff t2)))
                   (new-o (- (order t1)
                             (order t2)))
                   (new-t (make-term new-o new-c))
                   (mult (mul-terms L2 (list new-t)))
                   (diff (add-terms L1
                                    (negate-terms mult))) )
              (let ((rest-of-result (div-terms diff L2)))
                (list (cons new-t (car rest-of-result))
                      (cadr rest-of-result))))))))

(define (remainder-terms L1 L2)
  (let ((div (div-terms L1 L2)))
    (cadr div)))

(define (quotient-terms L1 L2)
  (let ((div (div-terms L1 L2)))
    (car div)))

(define (pseudoremainder-terms a b)
  (let* ((t1 (first-term a))
         (o1 (order t1))
         (t2 (first-term b))
         (o2 (order t2))
         (c (coeff t2))
         (k (expt c (+ 1 o1 (- o2)))))
    (cadr (div-terms (map (lambda (t)
                            (make-term (order t)
                                       (* k (coeff t))))
                          a)
                     b))))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (let* ((gcd-res (gcd-terms b (pseudoremainder-terms a b)))
             (coeff-list (map cadr gcd-res))
             (coeff-gcd (apply gcd coeff-list)))
        (map (lambda (t)
               (make-term (order t)
                          (/ (coeff t)
                             coeff-gcd)))
             gcd-res))))

(define (map-coeffs fn term-list)
  (map (lambda (t)
         (make-term (order t)
                    (fn (coeff t))))
       term-list))

(define (reduce-terms n d)
  (let* ((nd-gcd (gcd-terms n d))
         (o1 (max (order (first-term n))
                  (order (first-term d))))
         (o2 (order (first-term nd-gcd)))
         (c (coeff (first-term nd-gcd)))
         (k (expt c (+ 1 o1 (- o2))))
         (ni (map-coeffs (lambda (c) (* c k)) n))
         (di (map-coeffs (lambda (c) (* c k)) d))
         (nn (quotient-terms ni nd-gcd))
         (dd (quotient-terms di nd-gcd)))
    (list nn dd)))

(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))

(define (the-empty-termlist) '())

(define (first-term term-list)
  (car term-list))

(define (rest-terms term-list)
  (cdr term-list))

(define (empty-termlist? term-list)
  (null? term-list))

(define (make-term order coeff)
  (list order coeff))

(define (order term)
  (car term))

(define (coeff term)
  (cadr term))

(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))

(define (negate-terms termlist)
  (map (lambda (term)
         (make-term (order term)
                    (negate (coeff term))))
       termlist))