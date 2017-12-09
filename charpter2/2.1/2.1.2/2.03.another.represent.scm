(define (make-rectangle length width)
  (cons length width))

(define (length-rectangle r)
  (car r))

(define (width-rectangle r)
  (cdr r))

(define (length-of-rectangle r)
  (let ((length (length-rectangle r)))
    (let ((start (start-segment length))
          (end (end-segment length)))
      (- (x-point end)
         (x-point start)))))

(define (width-of-rectangle r)
  (let ((width (width-rectangle r)))
    (let ((start (start-segment width))
          (end (end-segment width)))
      (- (y-point end)
         (y-point start)))))