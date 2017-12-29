(load "assembler.scm")
(load "generate-execute-procedures.scm")
(load "machine-model.scm")

(define expt
  (make-machine '(b n continue val)
                `((= ,=) (* ,*) (- ,-))
                '(init
                      (assign continue (label expt-done))
                  expt-loop
                      (test (op =) (reg n) (const 0))
                      (branch (label base-case))
                      (save continue)
                      (assign n (op -) (reg n) (const 1))
                      (assign continue (label after-expt))
                      (goto (label expt-loop))
                  after-expt
                      (restore continue)
                      (assign val (op *) (reg b) (reg val))
                      (goto (reg continue))
                  base-case
                      (assign val (const 1))
                      (goto (reg continue))
                  expt-done)))

(set-register-contents! expt 'b 2)
(set-register-contents! expt 'n 10)
(start expt)
(display "expt: ")
(display (get-register-contents expt 'val))
(newline)
(display "instruction-count: ")
(display (expt 'get-instruction-count))