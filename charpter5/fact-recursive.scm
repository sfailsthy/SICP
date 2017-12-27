(load "machine-model.scm")

(define fact-recursive
  (make-machine '(n continue val)
                `((= ,=) (- ,-) (* ,*))
                '(init
                     (assign continue (label fact-done))
                  fact-loop
                     (test (op =) (reg n) (const 1))
                     (branch (label base-case))
                     (save continue)
                     (save n)
                     (assign n (op -) (reg n) (const 1))
                     (assign continue (label after-fact))
                     (goto (label fact-loop))
                  after-fact
                     (restore n)
                     (restore continue)
                     (assign val (op *) (reg n) (reg val))
                     (goto (reg continue))
                  base-case
                     (assign val (const 1))
                     (goto (reg continue))
                  fact-done)))

(set-register-contents! fact-recursive 'n 6)
(start fact-recursive)
(get-register-contents fact-recursive 'val)