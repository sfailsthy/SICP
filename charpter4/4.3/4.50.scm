(define (ramb? exp)
  (tagged-list? exp 'ramb))

(define (ramb-choices exp)
  (shuffle-list (cdr exp)))

(define (analyze-ramb exp)
  (analyze-amb (cons 'amb (ramb-choices exp))))

(define (shuffle-list lst)
  (define (random-shuffle result rest)
    (if (null? rest)
        result
        (let* ((pos (random (length rest)))
               (item (list-ref rest pos)))
          (if (= pos 0)
              (random-shuffle (append result (list item))
                              (cdr rest))
              (let ((first (car rest)))
                (random-shuffle (append result (list item))
                                (insert! first
                                         (- pos 1)
                                         (cdr (delete! pos rest)))))))))
  (random-shuffle '() lst))

(define (insert! item k lst)
  (if (or (= k 0)
          (null? lst))
      (append (list item) lst)
      (cons (car lst) (insert! item (- k 1) (cdr lst)))))

(define (delete! k lst)
  (cond ((null? lst)
         '())
        ((= k 0)
         (cdr lst))
        (else
         (cons (car lst)
               (delete! (- k 1)
                        (cdr lst))))))