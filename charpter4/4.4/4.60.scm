;;--------4.60-----------add-to-file-------------
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (symbol-list->string person)
  (accumulate string-append "" (map symbol->string person)))

(define (symbol-list>? person1 person2)
  (string>? (symbol-list->string person1)
            (symbol-list->string person2)))
;;-----------------------------------------------------


(assert! (rule (ays-lives-near ?p1 ?p2)
               (and (address ?p1 (?town . ?rest-1))
                    (address ?p2 (?town . ?rest-2))
                    (lisp-value symbol-list>? ?p1 ?p2))))