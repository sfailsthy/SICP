(define (make-account balance password)

  (let ((try-times 0)
        (max-try-times 7))

    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))

    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)

    (define (password-match? given-password)
      (eq? given-password password))

    (define (display-wrong-password-message useless-arg)
      (display "Incorrect password"))

    (define (call-the-cops)
      (error "You try too many times, calling the cops"))

    (define (dispatch given-password m)
      (if (password-match? given-password)
          (begin
            (set! try-times 0)
            (cond ((eq? m 'withdraw)
                   withdraw)
                  ((eq? m 'deposit)
                   deposit)
                  (else
                   (error "Unknown request -- MAKE-ACCOUNT"
                          m))))

          (begin
            (set! try-times (+ 1 try-times))
            (if (>= try-times max-try-times)
                (call-the-cops)
                display-wrong-password-message))))

    dispatch))