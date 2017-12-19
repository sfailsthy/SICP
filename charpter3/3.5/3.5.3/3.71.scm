(load "3.70.scm")

(define (Ramanujan stream)
  (define (stream-cadr s)
    (stream-car (stream-cdr s)))

  (define (stream-cddr s)
    (stream-cdr (stream-cdr s)))

  (let ((scar (stream-car stream))
        (scadr (stream-cadr stream)))
    (if (= (sum-triple scar)
           (sum-triple scadr))
        (cons-stream (list (sum-triple scar) scar scadr)
                     (Ramanujan (stream-cddr stream)))
        (Ramanujan (stream-cdr stream)))))

(define (triple x)
  (* x x x))

(define (sum-triple x)
  (+ (triple (car x))
     (triple (cadr x))))

(define Ramanujan-numbers
  (Ramanujan (weighted-pairs sum-triple integers integers)))