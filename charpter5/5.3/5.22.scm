(load "../5.2/assembler.scm")
(load "../5.2/generate-execute-procedures.scm")
(load "../5.2/machine-model.scm")

;;append
(define append-machine
  (make-machine '(x y continue val)
                `((null? ,null?) (car ,car) (cdr ,cdr) (cons ,cons))
                '(init
                      (assign continue (label append-done))
                  append-loop
                      (test (op null?) (reg x))
                      (branch (label null-x))
                      (save continue)
                      (assign continue (label after-append-cdr))
                      (save x)
                      (assign x (op cdr) (reg x))
                      (goto (label append-loop))
                  after-append-cdr
                      (restore x)
                      (assign x (op car) (reg x))
                      (restore continue)
                      (assign y (reg val))
                      (assign val (op cons) (reg x) (reg y))
                      (goto (reg continue))
                  null-x
                      (assign val (reg y))
                      (goto (reg continue))
                  append-done)))

(set-register-contents! append-machine 'x '(1 (2 3)))
(set-register-contents! append-machine 'y '(8 9))
(start append-machine)
(display "append: ")
(display (get-register-contents append-machine 'val))
(newline)
(display "append instruction count: ")
(display (append-machine 'get-instruction-count))
(newline)


;;append!
(define append!-machine
  (make-machine '(x y temp temp1 val)
                `((null? ,null?) (cdr ,cdr) (set-cdr! ,set-cdr!))
                '(append!-loop
                      (assign temp (reg x))
                      (assign val (reg x))
                  last-pair
                      (assign temp1 (op cdr) (reg temp))
                      (test (op null?) (reg temp1))
                      (branch (label null-x))
                      (assign temp (reg temp1))
                      (goto (label last-pair))
                  null-x
                      ;temp is last-pair x
                      (goto (label after-last-pair))
                  after-last-pair
                      (perform (op set-cdr!) (reg temp) (reg y));val=(cons (last-pair x) y)
                      (goto (label append!-done))
                  append!-done)))

(set-register-contents! append!-machine 'x '(1 (2 3) (4 (5 6))))
(set-register-contents! append!-machine 'y '(8 9))
(start append!-machine)
(display "append!: ")
(display (get-register-contents append!-machine 'val))
(newline)
(display "append! instruction count: ")
(display (append!-machine 'get-instruction-count))