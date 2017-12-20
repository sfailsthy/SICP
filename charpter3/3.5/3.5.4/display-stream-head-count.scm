(define (display-line x)
  (newline)
  (display x))

(define (display-stream-head-count stream count)
  (let ((s (stream-head stream count)))
    (for-each display-line s)))