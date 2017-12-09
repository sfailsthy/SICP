(load "2.29.a.scm")

(define (structure-is-mobile? structure)
  (pair? structure))

(define (branch-weight branch)
  (let ((struct (branch-structure branch)))
    (if (structure-is-mobile? struct)
        (total-weight struct)
        struct)))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

      
