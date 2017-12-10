(define top-mid (make-vect 0.5 1.0))
(define left-mid (make-vect 0.0 0.5))
(define right-mid (make-vect 1.0 0.5))
(define bottom-mid (make-vect 0.5 0.0))

($line top-mid right-mid)
($line right-mid bottom-mid)
($line bottom-mid left-mid)
($line left-mid top-mid)