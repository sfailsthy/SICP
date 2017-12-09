(load "2.07.scm")
(load "2.08.scm")

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i)
        (upper-bound i))
     2.0))

(define (width i)
  (/ (- (upper-bound i)
        (lower-bound i))
     2.0))

(define (make-center-percent c p)
  (let ((width (* c p)))
    (make-center-width c width)))

(define (percent i)
  (let ((c (center i))
        (w (width i)))
    (/ w c)))