(load "4.06.scm")

(define (named-let? exp)
  (and (let? exp)
       (symbol? (cadr exp))))

(define (named-let-proc exp)
  (cadr exp))

(define (named-let-bindings exp)
  (caddr exp))

(define (named-let-body exp)
  (cdddr exp))

(define (let->combination exp)
  (if (named-let? exp)
      (sequence->exp (list (make-definition (named-let-proc exp)
                                            (map car (named-let-bindings exp))
                                            (named-let-body exp))
                           (make-application (named-let-proc exp)
                                             (map cadr (named-let-bindings exp)))))
      (cons (make-lambda (let-vars exp) (let-body exp))
            (let-inits exp))))

(define (make-application proc parameters)
  (cons proc parameters))

(define (make-definition var parameters body)
  (list 'define
        var
        (make-lambda parameters body)))