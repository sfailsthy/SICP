(load "../5.2/assembler.scm")
(load "../5.2/generate-execute-procedures.scm")
(load "../5.2/machine-model.scm")

(define count-leaves-recursive
  (make-machine '(tree continue val)
                `((+ ,+) (null? ,null?) (pair? ,pair?) (car ,car) (cdr ,cdr))
                '(init
                      (assign continue (label count-done))
                  count-loop
                      (test (op null?) (reg tree))
                      (branch (label null-case))
                      (test (op pair?) (reg tree))
                      (branch (label count-pair))
                      (goto (label not-pair-case))
                  count-pair
                      (save continue)
                      (assign continue (label after-count-car))
                      (save tree)
                      (assign tree (op car) (reg tree))
                      (goto (label count-loop))
                  after-count-car
                      (restore tree)
                      (assign tree (op cdr) (reg tree))
                      (assign continue (label after-count-cdr))
                      (save val)
                      (goto (label count-loop))
                  after-count-cdr
                      (assign tree (reg val))
                      (restore val)
                      (restore continue)
                      (assign val (op +) (reg val) (reg tree))
                      (goto (reg continue))
                  null-case
                      (assign val (const 0))
                      (goto (reg continue))
                  not-pair-case
                      (assign val (const 1))
                      (goto (reg continue))
                  count-done)))

(set-register-contents! count-leaves-recursive
                        'tree '(1 (3 4) 5 (6 (7 3) 9)))

(start count-leaves-recursive)

(display (get-register-contents count-leaves-recursive 'val))
(newline)
(display "instruction count: ")
(display (count-leaves-recursive 'get-instruction-count))