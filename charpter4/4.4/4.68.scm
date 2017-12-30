(assert! (rule (reverse () ())))

(assert! (rule (reverse ?x ?y)
               (and (append-to-form (?first) ?rest ?x)
                    (append-to-form ?rev-rest (?first) ?y)
                    (reverse ?rest ?rev-rest))))