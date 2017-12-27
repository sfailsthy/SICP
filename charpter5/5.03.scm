(load "machine-model.scm")

(define (good-enough? guess x)
  (< (abs (- (square guess)
             x))
     0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y)
     2))

(define sqrt-with-ops
  (make-machine '(x guess)
                `((good-enough? ,good-enough?)
                  (improve ,improve))
                '(init
                      (assign guess (const 1.0))
                  sqrt-iter
                      (test (op good-enough?)
                            (reg guess)
                            (reg x))
                      (branch (label end-sqrt))
                      (assign guess
                              (op improve)
                              (reg guess)
                              (reg x))
                      (goto (label sqrt-iter))
                  end-sqrt)))

(set-register-contents! sqrt-with-ops 'x 2)
(start sqrt-with-ops)
(display "sqrt: ")
(display (get-register-contents sqrt-with-ops 'guess))
(newline)
(display "sqrt-with-ops instruction-count: ")
(display (sqrt-with-ops 'get-instruction-count))
(newline)

(define sqrt-full
  (make-machine '(x guess r1)
                `((< ,<) (abs ,abs) (- ,-) (/ ,/)
                  (square ,square) (average ,average))
                '(init
                      (assign guess
                              (const 1.0))
                  sqrt-iter
                      ;good-enough?
                      (assign r1
                              (op square) (reg guess))
                      (assign r1 (op -) (reg r1) (reg x))
                      (assign r1 (op abs) (reg r1))
                      (test (op <) (reg r1) (const 0.001))
                      (branch (label end-sqrt))
                      ;not good-enough? improve
                      (assign r1 (op /) (reg x) (reg guess))
                      (assign guess (op average) (reg guess) (reg r1))
                      (goto (label sqrt-iter))
                  end-sqrt)))

(set-register-contents! sqrt-full 'x 2)
(start sqrt-full)
(display "sqrt: ")
(display (get-register-contents sqrt-full 'guess))
(newline)
(display "sqrt-full instruction-count: ")
(display (sqrt-full 'get-instruction-count))