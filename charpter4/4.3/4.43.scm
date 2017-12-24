(define (father-daughter)
  (let ((Moore 'Mary)
        (Barnacle 'Melissa)
        (Hall (amb 'Gabrielle 'Lorna))
        (Downing (amb 'Gabrielle 'Lorna 'Rosalind))
        (Parker (amb 'Lorna 'Rosalind)))
    (require (cond ((eq? Hall 'Gabrielle) (eq? Parker 'Rosalind))
                   ((eq? Downing 'Gabrielle) (eq? Parker 'Melissa))
                   (else false)))
    (require (distinct? (list Hall Downing Parker)))
    (list (list 'Barnacle Barnacle)
          (list 'Moore Moore)
          (list 'Hall Hall)
          (list 'Downing Downing)
          (list 'Parker Parker))))