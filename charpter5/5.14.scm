(load "machine-model.scm")

(define fact-recursive
  (make-machine '(n continue val count)
                `((= ,=) (+ ,+) (- ,-) (* ,*) (read ,read) (print ,(lambda (x) (display x) (newline))))
                '(init
                     (assign count (const 0))
                     (assign n (op read))
                     (assign continue (label fact-done))
                  fact-loop
                     (test (op =) (reg n) (const 1))
                     (branch (label base-case))
                     (save continue)
                     (assign count (op +) (reg count) (const 1))
                     (save n)
                     (assign count (op +) (reg count) (const 1))
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
                  fact-done
                     (perform (op print) (reg count))
                     (goto (label init)))))


(start fact-recursive)