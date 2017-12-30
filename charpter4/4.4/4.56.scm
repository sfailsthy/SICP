(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?where))

(and (salary (Bitdiddle Ben) ?ben)
     (salary ?person ?amount)
     (lisp-value > ?ben ?amount))

(and (supervisor ?person ?boss)
     (not (job ?boss (computer . ?x)))
     (job ?boss ?bossjob))