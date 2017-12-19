(define (smooth s)
  (stream-map (lambda (x1 x2) (/ (+ x1 x2) 2))
              (cons-stream 0 s)
              s))

(define (make-zeor-crosssings input-stream smooth)
  (let ((after-smooth (smooth input-stream)))
    (stream-map sign-change-detector after-smooth (cons-stream 0 after-smooth))))