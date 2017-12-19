(load "3.70.scm")

(define (seq stream)
  (define (stream-cadr s)
    (stream-car (stream-cdr s)))

  (define (stream-cddr s)
    (stream-cdr (stream-cdr s)))

  (define (stream-caddr s)
    (stream-car (stream-cddr s)))

  (define (stream-cdddr s)
    (stream-cdr (stream-cddr s)))
  
  (let ((scar (stream-car stream))
        (scadr (stream-cadr stream))
        (scaddr (stream-caddr stream)))
    (if (and (= (sum-square scar)
                (sum-square scadr))
             (= (sum-square scar)
                (sum-square scaddr)))
        (cons-stream (list (sum-square scar) scar scadr scaddr)
                     (seq (stream-cdddr stream)))
        (seq (stream-cdr stream)))))

(define (sum-square x)
  (+ (square (car x))
     (square (cadr x))))

(define seq-numbers
  (seq (weighted-pairs sum-square integers integers)))