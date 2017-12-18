(define (make-deque)
  (cons '() '()))

(define (front-ptr deque)
  (car deque))

(define (rear-ptr deque)
  (cdr deque))

(define (set-front-ptr! deque item)
  (set-car! deque item))

(define (set-rear-ptr! deque item)
  (set-cdr! deque item))

(define (empty-deque? deque)
  (null? (front-ptr deque)))

(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an empty deque"
             deque)
      (caar (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR called with an empty deque"
             deque)
      (caar (rear-ptr deque))))

(define (front-insert-deque! deque item)
  (let ((new-pair (cons (cons item '())
                        '())))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           (print-deque deque))
          (else
           (set-cdr! (car (front-ptr deque)) new-pair)
           (set-cdr! new-pair (front-ptr deque))
           (set-front-ptr! deque new-pair)
           (print-deque deque)))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (cons (cons item '())
                        '())))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           (print-deque deque))
          (else
           (set-cdr! (car new-pair) (rear-ptr deque))
           (set-cdr! (rear-ptr deque) new-pair)
           (set-rear-ptr! deque new-pair)
           (print-deque deque)))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "FRONT-DELETE called with an empty deque"
                deque))
        (else
         (set-front-ptr! deque (cdr (front-ptr deque)))
         (set-cdr! (car (front-ptr deque)) '())
         (print-deque deque))))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "REAR-DELETE called with an empty deque"
                deque))
        (else
         (set-rear-ptr! deque (cdar (rear-ptr deque)))
         (set-cdr! (rear-ptr deque) '())
         (print-deque deque))))

(define (print-deque deque)
  (define (iter res deq)
    (if (or (null? deq)
            (empty-deque? deq))
        res
        (iter (append res (list (caaar deq)))
              (cons (cdar deq) (cdr deq)))))
  (iter '() deque))