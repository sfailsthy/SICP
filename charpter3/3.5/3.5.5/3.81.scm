(define (rand-update x)
  (remainder (+ (* 13 x) 5) 24))

(define rand-init (rand-update (expt 2 32)))
 
(define (rand-generator commands) 
   (define (rand-helper num remaining-commands) 
     (let ((next-command (stream-car remaining-commands))) 
       (cond ((eq? next-command 'generate) 
              (cons-stream num 
                           (rand-helper (rand-update num) 
                                        (stream-cdr remaining-commands)))) 
             ((pair? next-command) 
              (if (eq? (car next-command) 'reset) 
                  (cons-stream (cdr (stream-car remaining-commands)) 
                      (rand-helper (rand-update (cdr (stream-car remaining-commands))) 
                                   (stream-cdr remaining-commands))) 
                  (error "bad command -- " next-commmand))) 
             (else (error "bad command -- " next-commmand))))) 
   (rand-helper rand-init commands)) 
  
;;; testing 
  
;;; generate stream of commands 
(define gen-stream
  (cons-stream
   (cons 'reset 12)
   (cons-stream 'generate
                (cons-stream (cons 'reset 100)
                             (cons-stream 'generate
                                          gen-stream)))))

(define rands (rand-generator gen-stream)) 