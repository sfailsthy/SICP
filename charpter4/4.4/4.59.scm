(assert! (meeting accounting (Monday 9am)))
(assert! (meeting administration (Monday 10am)))
(assert! (meeting computer (Wednesday 3pm)))
(assert! (meeting administration (Friday 1pm)))
(assert! (meeting whole-company (Wednesday 4pm)))

(meeting ?x (Friday . ?time))

(assert! (rule (meeting-time ?person ?day-and-time)
               (or (meeting whole-company ?day-and-time)
                   (and (job ?person (?div . ?x))
                        (meeting ?div ?day-and-time)))))

(meeting-time (Hacker Alyssa P) ?time)