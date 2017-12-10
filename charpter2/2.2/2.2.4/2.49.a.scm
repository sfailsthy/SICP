(define top-left (make-vect 0.0 1.0))
(define top-right (make-vect 1.0 1.0))
(define bottom-left (make-vect 0.0 0.0))
(define bottom-right (make-vect 1.0 0.0))

($line top-left top-right)
($line top-left bottom-left)
($line top-right bottom-right)
($line bottom-left bottom-right)