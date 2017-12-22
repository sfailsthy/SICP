;eval.scm
((and? exp) (eval (and->if exp) env))
((or? exp) (eval (or->if exp) env))

; and
(define (and? exp)
  (tagged-list? exp 'and))

(define (and-exps exp)
  (cdr exp))

(define (and->if exp)
  (expand-and-exps (and-exps exp)))

(define (expand-and-exps exps)
  (if (null? exps)
      'true
      (make-if (car exps)
               (expand-and-exps (cdr exps))
               'false)))
; or
(define (or? exp)
  (tagged-list? exp 'or))

(define (or-exps exp)
  (cdr exp))

(define (or->if exp)
  (expand-or-exps (or-exps exp)))

(define (expand-or-exps exps)
  (if (null? exps)
      'false
      (make-if (car exps)
               'true
               (expand-or-exps (cdr exps)))))