(load "2.02.scm")

(define (make-rectangle length-1 length-2 width-1 width-2)
  (cons (cons length-1 length-2)
        (cons width-1 width-2)))

(define (length-1-rectangle r)
  (car (car r)))

(define (length-2-rectangle r)
  (cdr (car r)))

(define (width-1-rectangle r)
  (car (cdr r)))

(define (width-2-rectangle r)
  (cdr (cdr r)))

(define (print-rectangle r)
    (let ((l1 (length-1-rectangle r))
          (l2 (length-2-rectangle r))
          (w1 (width-1-rectangle r))
          (w2 (width-2-rectangle r)))

        (newline)
        (display "Length 1:")
        (print-point (start-segment l1))
        (print-point (end-segment l1))

        (newline)
        (display "Length 2:")
        (print-point (start-segment l2))
        (print-point (end-segment l2))

        (newline)
        (display "Width 1:")
        (print-point (start-segment w1))
        (print-point (end-segment w1))

        (newline)
        (display "Width 2:")
        (print-point (start-segment w2))
        (print-point (end-segment w2))))

(define (length-of-rectangle r)
  (let ((length (length-1-rectangle r)))
    (let ((start (start-segment length))
          (end (end-segment length)))
      (- (x-point end)
         (x-point start)))))

(define (width-of-rectangle r)
  (let ((width (width-1-rectangle r)))
    (let ((start (start-segment width))
          (end (end-segment width)))
      (- (y-point end)
         (y-point start)))))