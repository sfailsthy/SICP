;primitive-procedure.scm
(list 'real-time-clock real-time-clock)

;M-Eval Input
(define (f n) (if (= n 0) 1 (* n (f (- n 1)))))

(let ((s (real-time-clock))) (f 100) (- (real-time-clock) s))