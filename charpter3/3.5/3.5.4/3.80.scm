(load "solve-exp.scm")

(define (RLC R L C dt)
  (lambda (Vc0 Il0)
    (define Vc (integral (delay dVc) Vc0 dt))
    (define Il (integral (delay dIl) Il0 dt))
    (define dVc (scale-stream Il (- (/ 1 C))))
    (define dIl (add-streams (scale-stream Vc
                                           (/ 1 L))
                             (scale-stream Il
                                           (- (/ R L)))))
    (stream-map cons Vc Il)))