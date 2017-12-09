(load "2.29.b.scm")

(define (branch-torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (branch-balance? branch)
  (let ((struct (branch-structure branch)))
    (if (structure-is-mobile? struct)
        (mobile-balance? struct)
        #t)))

(define (mobile-balance? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (= (branch-torque left)
            (branch-torque right))
         (branch-balance? left)
         (branch-balance? right))))
         