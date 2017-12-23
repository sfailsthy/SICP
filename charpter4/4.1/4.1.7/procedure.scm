; (define (scan-out-defines body)
;   (let* ((definitions (filter definition? body))
;          (not-definitions (filter (lambda (exp)
;                                     (not (definition? exp)))
;                                   body))
;          (vars (map definition-variable definitions))
;          (vals (map definition-value definitions)))
;     (define (make-unassigned-binding var)
;       (list var '*unassigned*))
;     (define (make-assignment var val)
;       (list 'set! var val))
;     (if (null? definitions)
;         body
;         (list (make-let (map make-unassigned-binding vars)
;                   (append (map make-assignment vars vals)
;                           not-definitions))))))


; (define (scan-out-defines procedure-body)
;   (let ((body (filter (lambda (exp) (not (definition? exp)))
;                       procedure-body))
;         (defines (filter definition? procedure-body)))
;     (if (null? defines)
;         procedure-body
;         (let ((define-vars (map definition-variable defines))
;               (define-vals (map definition-value defines)))
;           (list (make-let (map (lambda (var) (list var ''*unassigned*))
;                                define-vars)
;                           (append (map (lambda (var val)
;                                          (list 'set! var val))
;                                        define-vars
;                                        define-vals)
;                                   body)))))))

(define (make-let vars-vals body)
  (list 'let vars-vals body))

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

(define (procedure-parameters p)
  (cadr p))

(define (procedure-body p)
  (caddr p))

(define (procedure-environment p)
  (cadddr p))