(load "accumulate.scm")
(load "2.36.scm")

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v))
       m))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row-of-m)
           (map (lambda (col-of-n)
                  (dot-product row-of-m col-of-n))
                cols))
         m)))
  