(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))