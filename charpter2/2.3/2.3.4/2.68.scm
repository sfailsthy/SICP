(load "huffman-represent.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (define (iter current-branch result)
    (if (leaf? current-branch)
        result
        (let ((left (left-branch current-branch))
              (right (right-branch current-branch)))
          (let ((left-symbols (symbols left)))
            (if (element-of-set? symbol left-symbols)
                (iter left (append result
                                   (list 0)))
                (iter right (append result
                                    (list 1))))))))
  
  (let ((symbol-list (symbols tree)))
    (if (element-of-set? symbol symbol-list)
        (iter tree '())
        (error "unknown symbol"))))

(define (element-of-set? x set)
  (cond ((null? set)
         false)
        ((equal? x (car set))
         true)
        (else
         (element-of-set? x (cdr set)))))