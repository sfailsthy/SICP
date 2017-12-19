(define (euler-transform s)
  (let ((s0 (stream-ref s 0))  ;;S(n-1)
        (s1 (stream-ref s 1))  ;;S(n)
        (s2 (stream-ref s 2))) ;;S(n+1)
    (cons-stream (- s2
                    (/ (square (- s2 s1))
                       (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))