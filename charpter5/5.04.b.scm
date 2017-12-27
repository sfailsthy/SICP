(load "machine-model.scm")

(define expt
  (make-machine '(b n counter product)
                `((= ,=) (* ,*) (- ,-))
                '(init
                      (assign counter (reg n))
                      (assign product (const 1))
                  expt-iter
                      (test (op =) (reg counter) (const 0))
                      (branch (label expt-done))
                      (assign counter (op -) (reg counter) (const 1))
                      (assign product (op *) (reg b) (reg product))
                      (goto (label expt-iter))
                  expt-done)))

(set-register-contents! expt 'b 2)
(set-register-contents! expt 'n 10)
(start expt)
(display "expt: ")
(display (get-register-contents expt 'product))
(newline)
(display "instruction-count: ")
(display (expt 'get-instruction-count))