; (do <body>
;   <condition>)
; =>
; (begin
;   <body>
;   (while <condition>
;          <body>))
; from C/C++

(define (do? exp)
  (tagged-list? exp 'do))

(define (do-condition exp)
  (caddr exp))

(define (do-body exp)
  (cadr exp))

(define (do->while exp)
  ;(make-while (do-condition exp)
              ;(do-body exp)))
  (make-begin (append (list (do-body exp))
                      (list (make-while (do-condition exp)
                                        (do-body exp))))))

; ;do test
; ;;; M-Eval input:
; (define i 0)

; ;;; M-Eval output:
; ok

; ;;; M-Eval input:
; (do (set! i (+ i 1)) (<= i 10))

; ;;; M-Eval output:
; done

; ;;; M-Eval input:
; i

; ;;; M-Eval output:
; 11

; ;;; M-Eval input:
; (define (sum n)
;   (let ((i 0)
;         (s 0))
;     (do (begin
;           (set! s (+ s i))
;           (set! i (+ i 1)))
;       (<= i n))
;     s))

; ;;; M-Eval output:
; ok

; ;;; M-Eval input:
; (sum 10)

; ;;; M-Eval output:
; 55


;C/C++
; int i = 0;
; int s = 0;
; for(;i <= 10;i++){
;     s += i;
; }
; (for (<condition>
;       <expression>)
;      <statement>)
; =>(while <condition>
;          <statement>
;          <expression>))


(define (for? exp)
  (tagged-list? exp 'for))

(define (for-condition exp)
  (caadr exp))

(define (for-expression exp)
  (cadadr exp))

(define (for-statement exp)
  (caddr exp))

(define (for->while exp)
  (make-while (for-condition exp)
              (make-begin (append (list (for-statement exp))
                                  (list (for-expression exp))))))

; for-test
; ;;; M-Eval input:
; (define (sum n)
;   (let ((i 0)
;         (s 0))
;     (for ((<= i n) (set! i (+ i 1)))
;       (set! s (+ s i)))
;     s))

; ;;; M-Eval output:
; ok

; ;;; M-Eval input:
; (sum 100)

; ;;; M-Eval output:
; 5050

;from C/C++
;(while <condition>
;       <body>)

(define (while? exp)
  (tagged-list? exp 'while))

(define (while-condition exp)
  (cadr exp))

(define (while-body exp)
  (cddr exp))

(define (make-while condition body)
  (list 'while condition body))

(define (while-iter exp)
  (list 'define '(while-iter)
        (make-if (while-condition exp)
                 (sequence->exp (append (while-body exp)
                                        (list '(while-iter))))
                 ''done)))

(define (while->combination exp)
  ;avoid name clash
  (make-application (make-lambda '()
                                 (list (sequence->exp (list (while-iter exp)
                                                            '(while-iter)))))
                    '()))

(define (make-application proc parameters)
  (cons proc parameters))
;;while test
; ;;; M-Eval input:
; (define (sum n)
;   (let ((i 0)
;         (s 0))
;     (while (<= i n)
;            (set! s (+ s i))
;            (set! i (+ i 1)))
;     s))

; ;;; M-Eval output:
; ok

; ;;; M-Eval input:
; (sum 100)

; ;;; M-Eval output:
; 5050

; ;;; M-Eval input:
; (define i 0)

; ;;; M-Eval output:
; ok

; ;;; M-Eval input:
; (while (<= i 10) (set! i (+ i 1)))

; ;;; M-Eval output:
; done

; ;;; M-Eval input:
; i

; ;;; M-Eval output:
; 11