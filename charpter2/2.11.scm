(load "2.07.scm")
(load "2.08.scm")

(define (new-mul-interval x y)
  ;; endpoint-sign returns: 
  ;;     +1 if both endpoints non-negative, 
  ;;     -1 if both negative, 
  ;;      0 if opposite sign 
  (define (endpoint-sign i)
    (cond ((and (>= (lower-bound i) 0)
                (>= (upper-bound i) 0))
           1)
          ((and (< (lower-bound i) 0)
                (< (upper-bound i) 0))
           -1)
          (else
           0)))

  (let ((es-x (endpoint-sign x))
        (es-y (endpoint-sign y))
        (x-low (lower-bound x))
        (x-up (upper-bound x))
        (y-low (lower-bound y))
        (y-up (upper-bound y)))
    (cond ((> es-x 0)
           (cond ((> es-y 0)
                  (make-interval (* x-low y-low) (* x-up y-up)))
                 ((< es-y 0)
                  (make-interval (* x-up y-low) (* x-low y-up)))
                 (else
                  (make-interval (* x-up y-low) (* x-up y-up)))))
          ((< es-x 0)
           (cond ((> es-y 0)
                  (make-interval (* x-low y-up) (* x-up y-low)))
                 ((< es-y 0)
                  (make-interval  (* x-up y-up) (* x-low y-low)))
                 (else
                  (make-interval  (* x-low y-up) (* x-low y-low)))))
          (else
           (cond ((> es-y 0)
                  (make-interval (* x-low y-up) (* x-up y-up)))
                 ((< es-y 0)
                  (make-interval (* x-up y-low) (* x-low y-low)))
                 (else
                  (make-interval  (min (* x-low y-up)
                                       (* x-up y-low))
                                  (max (* x-low y-low)
                                       (* x-up y-up)))))))))
(define (eql-interval? a b) 
   (and (= (upper-bound a) (upper-bound b)) 
        (= (lower-bound a) (lower-bound b)))) 
  
;; Fails if the new mult doesn't return the same answer as the old 
;; naive mult. 
(define (ensure-mult-works aH aL bH bL) 
  (let ((a (make-interval aL aH)) 
        (b (make-interval bL bH)))
    (if (eql-interval? (mul-interval a b)
                       (new-mul-interval a b))
        true
        (error "new mult returns different value!"
               a  
               b  
               (mul-interval a b) 
               (new-mul-interval a b)))))

;; The following is overkill, but it found some errors in my 
;; work.  The first two #s are the endpoints of one interval, the last 
;; two are the other's.  There are 3 possible layouts (both pos, both 
;; neg, one pos one neg), with 0's added for edge cases (pos-0, 0-0, 
;; 0-neg). 
  
(ensure-mult-works  +10 +10   +10 +10) 
(ensure-mult-works  +10 +10   +00 +10) 
(ensure-mult-works  +10 +10   +00 +00) 
(ensure-mult-works  +10 +10   +10 -10) 
(ensure-mult-works  +10 +10   -10 +00) 
(ensure-mult-works  +10 +10   -10 -10) 
  
(ensure-mult-works  +00 +10   +10 +10) 
(ensure-mult-works  +00 +10   +00 +10) 
(ensure-mult-works  +00 +10   +00 +00) 
(ensure-mult-works  +00 +10   +10 -10) 
(ensure-mult-works  +00 +10   -10 +00) 
(ensure-mult-works  +00 +10   -10 -10) 
  
(ensure-mult-works  +00 +00   +10 +10) 
(ensure-mult-works  +00 +00   +00 +10) 
(ensure-mult-works  +00 +00   +00 +00) 
(ensure-mult-works  +00 +00   +10 -10) 
(ensure-mult-works  +00 +00   -10 +00) 
(ensure-mult-works  +00 +00   -10 -10) 
  
(ensure-mult-works  +10 -10   +10 +10) 
(ensure-mult-works  +10 -10   +00 +10) 
(ensure-mult-works  +10 -10   +00 +00) 
(ensure-mult-works  +10 -10   +10 -10) 
(ensure-mult-works  +10 -10   -10 +00) 
(ensure-mult-works  +10 -10   -10 -10) 
  
(ensure-mult-works  -10 +00   +10 +10) 
(ensure-mult-works  -10 +00   +00 +10) 
(ensure-mult-works  -10 +00   +00 +00) 
(ensure-mult-works  -10 +00   +10 -10) 
(ensure-mult-works  -10 +00   -10 +00) 
(ensure-mult-works  -10 +00   -10 -10) 
  
(ensure-mult-works  -10 -10   +10 +10) 
(ensure-mult-works  -10 -10   +00 +10) 
(ensure-mult-works  -10 -10   +00 +00) 
(ensure-mult-works  -10 -10   +10 -10) 
(ensure-mult-works  -10 -10   -10 +00) 
(ensure-mult-works  -10 -10   -10 -10) 