(load "accumulate.scm")
(load "enumerate-interval.scm")

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))

  (queen-cols board-size))

(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))

(define (safe? k positions)
  (define (iter-check row-of-new-queen rest-of-queens i)
    (if (null? rest-of-queens)
        #t
        (let ((row-of-current-queen (car rest-of-queens)))
          (if (or (= row-of-new-queen row-of-current-queen)
                  (= row-of-new-queen (+ row-of-current-queen i))
                  (= row-of-new-queen (- row-of-current-queen i)))
              #f
              (iter-check row-of-new-queen
                          (cdr rest-of-queens)
                          (+ i 1))))))
  (iter-check (car positions)
              (cdr positions)
              1))

(define empty-board '())

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (f n)
  (for-each (lambda (pos)
              (begin
                (display pos)
                (newline)))
            (queens n)))