(load "../5.2/assembler.scm")
(load "../5.2/generate-execute-procedures.scm")
(load "../5.2/machine-model.scm")

(define count-leaves-iter
  (make-machine '(tree n val continue)
                `((null? ,null?) (pair? ,pair?) (car ,car) (cdr ,cdr) (+ ,+))
                '(init
                      (assign n (const 0))
                      (assign continue (label count-done))
                  count-iter
                      (test (op null?) (reg tree))
                      (branch (label null-case))
                      (test (op pair?) (reg tree))
                      (branch (label count-pair))
                      (goto (label not-pair-case))
                  count-pair
                      (save continue)
                      (save tree)
                      (assign continue (label after-count-car))
                      (assign tree (op car) (reg tree))
                      (goto (label count-iter))
                  after-count-car
                      (restore tree)
                      (assign n (reg val))
                      (assign tree (op cdr) (reg tree))
                      (assign continue (label after-count-cdr))
                      (goto (label count-iter))
                  after-count-cdr
                      (assign n (reg val))
                      (restore continue)
                      (goto (reg continue))
                  null-case
                      (assign val (reg n))
                      (goto (reg continue))
                  not-pair-case
                      (assign val (op +) (reg n) (const 1))
                      (goto (reg continue))
                  count-done)))

(set-register-contents! count-leaves-iter
                        'tree '(1 (3 4) 5 (6 (7 3) 9)))

(start count-leaves-iter)

(display (get-register-contents count-leaves-iter 'val))
(newline)
(display "instruction count: ")
(display (count-leaves-iter 'get-instruction-count))