(define (if-fail? exp)
  (tagged-list? exp 'if-fail))

(define (analyze-if-fail exp)
  (let ((pproc (analyze (cadr exp)))
        (cproc (analyze (caddr exp))))
    (lambda (env succeed fail)
      (pproc env
             ;success
             (lambda (val fail2)
               (succeed val fail2))
             ;failure
             (lambda ()
               (cproc env
                      succeed
                      fail))))))