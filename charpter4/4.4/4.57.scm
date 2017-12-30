(assert! (rule (can-replace ?1 ?2)
               (and (or (and (job ?1 ?job)
                             (job ?2 ?job))
                        (and (job ?1 ?j1)
                             (job ?2 ?j2)
                             (can-do-job ?j1 ?j2)))
                    (not (same ?1 ?2)))))

(can-replace ?person (Fect Cy D))

(and (can-replace ?1 ?2)
     (salary ?1 ?s1)
     (salary ?2 ?s2)
     (lisp-value > ?s2 ?s1))