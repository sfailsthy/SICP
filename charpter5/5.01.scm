(load "machine-model.scm")

(define iter-fact
  (make-machine '(n product counter)
                `((> ,>) (* ,*) (+ ,+))
                '(init
                      (assign counter (const 1))
                      (assign product (const 1))
                  loop
                      (test (op >) (reg counter) (reg n))
                      (branch (label end-fact))
                      (assign product (op *) (reg counter) (reg product))
                      (assign counter (op +) (reg counter) (const 1))
                      (goto (label loop))
                  end-fact)))

(set-register-contents! iter-fact 'n 6)
(start iter-fact)
(get-register-contents iter-fact 'product)
                       