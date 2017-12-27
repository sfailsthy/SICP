(load "assembler.scm")
(load "generate-execute-procedures.scm")
(load "5.12.scm")
;;modify make-machine and lookup-register of make-new-machine


;;make-machine
(define (make-machine ops controller-text)
  (let ((machine (make-new-machine)))
    ; (for-each (lambda (register-name)
    ;             ((machine 'allocate-register) register-name))
    ;           register-names)
    ((machine 'install-operations) ops)
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))

;;make-register
(define (make-register name)
  (let ((contents '*unassigned*))
    (define (dispatch message)
      (cond ((eq? message 'get)
             contents)
            ((eq? message 'set)
             (lambda (value)
               (set! contents value)))
            (else
             (error "Unknown request -- REGISTER"
                    message))))
    dispatch))

(define (get-contents register)
  (register 'get))

(define (set-contents! register value)
  ((register 'set) value))

;;stack
(define (make-stack)
  (let ((s '())
        (number-pushes 0)
        (max-depth 0)
        (current-depth 0))
    
    (define (push x)
      (set! s (cons x s))
      (set! number-pushes (+ 1 number-pushes))
      (set! current-depth (+ 1 current-depth))
      (set! max-depth (max max-depth current-depth)))

    (define (pop)
      (if (null? s)
          (error "Empty stack -- POP")
          (let ((top (car s)))
            (set! s (cdr s))
            (set! current-depth (- current-depth 1))
            top)))

    (define (initialize)
      (set! s '())
      (set! number-pushes 0)
      (set! max-depth 0)
      (set! current-depth 0)
      'done)

    (define (print-statistics)
      (newline)
      (display (list 'total-pushes '= number-pushes
                     'maximum-depth '= max-depth)))
    
    (define (dispatch message)
      (cond ((eq? message 'push) push)
            ((eq? message 'pop) (pop))
            ((eq? message 'initialize) (initialize))
            ((eq? message 'print-statistics)
             (print-statistics))
            (else
             (error "Unknown request -- STACK"
                    message))))
    dispatch))

(define (push stack value)
  ((stack 'push) value))

(define (pop stack)
  (stack 'pop))

;;make-new-machine
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-struction-sequence '())
        ;-----------5.12-------------;
        (instruction-category '())
        (label-regs '())
        (stacked-regs '())
        (register-val-source '())
        ;------------------------------;
        )
    (let ((the-ops (list (list 'initial-stack
                               (lambda () (stack 'initialize)))
                         (list 'print-stack-statistics
                               (lambda () (stack 'print-statistics)))))
          (register-table (list (list 'pc pc)
                                (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: "
                   name)
            (set! register-table
                  (cons (list name
                              (make-register name))
                        register-table)))
        'register-allocated)

      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              ; -----------5.13
              (begin
                (allocate-register name)
                (lookup-register name)))))
              ; (error "Unknown register: "
              ;        name))))
              ; -------5.13---------

      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin ((instruction-execution-proc (car insts)))
                     (execute)))))

      ;----------------------5.12--------------------;
      (define (update-data cate lregs sregs sources)
        (set! instruction-category cate)
        (set! label-regs lregs)
        (set! stacked-regs sregs)
        (set! register-val-source sources)
        'finished)
      ;------------------------------------------------;

      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-struction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq)
                 (set! the-struction-sequence seq)))
              ((eq? message 'allocate-register)
               allocate-register)
              ((eq? message 'get-register)
               lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops)
                 (set! the-ops (append the-ops ops))))
              ((eq? message 'stack)
               stack)
              ((eq? message 'operations)
               the-ops)
              ;---------------------5.12--------------------;
              ((eq? message 'update-data) update-data)
              ((eq? message 'show-data) (show-data instruction-category
                                                   label-regs
                                                   stacked-regs
                                                   register-val-source))
              ;-----------------------------------------------;
              (else
               (error "Unknown request -- MACHINE"
                      message))))
      dispatch)))

(define (show machine)              ; add
  (machine 'show-data))             ;

(define (start machine)
  (machine 'start))

(define (get-register-contents machine register-name)
  (get-contents (get-register machine register-name)))

(define (set-register-contents! machine register-name value)
  (set-contents! (get-register machine register-name)
                 value)
  'done)

(define (get-register machine register-name)
  ((machine 'get-register) register-name))