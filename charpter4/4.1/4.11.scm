(define (enclosing-environment env)
  (cdr env))

(define (first-frame env)
  (car env))

(define the-empty-environment '())

(define (make-frame variables values)
  (cons 'frame
        (map cons variables values)))

(define (frame-pairs frame)
  (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-cdr! frame (cons (cons var val)
                        (frame-pairs frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars)
         (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars)
             (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable"
               var)
        (let ((res (assoc var (frame-pairs (first-frame env)))))
          (if res
              (cdr res)
              (env-loop (enclosing-environment env))))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable"
               var)
        (let ((res (assoc var (frame-pairs (first-frame env)))))
          (if res
              (set-cdr! res val)
              (env-loop (enclosing-environment env))))))
  (env-loop env))

(define (define-variable! var val env)
  (let* ((frame (first-frame env))
         (res (assoc var (frame-pairs frame))))
    (if res
        (set-cdr! res val)
        (add-binding-to-frame! var val frame))))