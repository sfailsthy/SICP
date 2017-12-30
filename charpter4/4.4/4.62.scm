(assert! (rule (last-pair (?x) (?x))))

(assert! (rule (last-pair (?u . ?v) (?x))
               (last-pair ?v (?x))))