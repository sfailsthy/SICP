(assert! (rule (bigshot ?person ?division)
               (and (job ?person (?division . ?r))
                    (or (not (supervisor ?person ?boss))
                        (and (supervisor ?person ?boss)
                             (not (job ?boss (?division . ?q))))))))

(bigshot ?who ?where)