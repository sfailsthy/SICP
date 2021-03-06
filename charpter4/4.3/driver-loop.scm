(load "amb.scm")
(load "ambeval.scm")
(load "analyze.scm")
(load "analyze-amb.scm")
(load "analyze-application.scm")
(load "analyze-assignment.scm")
(load "analyze-definition.scm")
(load "analyze-if.scm")
(load "analyze-lambda.scm")
(load "analyze-quoted.scm")
(load "analyze-self-evaluating.scm")
(load "analyze-sequence.scm")
(load "analyze-variable.scm")
(load "execute-application.scm")
(load "get-args.scm")
(load "../4.1/application.scm")
(load "../4.1/assignment.scm")
(load "../4.1/begin.scm")
(load "../4.1/cond.scm")
(load "../4.1/definition.scm")
(load "../4.1/environment.scm")
(load "../4.1/eval-assignment.scm")
(load "../4.1/eval-definition.scm")
(load "../4.1/eval-sequence.scm")
(load "../4.1/if.scm")
(load "../4.1/lambda.scm")
(load "../4.1/predicate.scm")
(load "primitive-procedure.scm")
(load "../4.1/procedure.scm")
(load "../4.1/quote.scm")
(load "../4.1/self-evaluating.scm")
(load "../4.1/setup-environment.scm")
(load "../4.1/tagged-list.scm")
(load "../4.1/variable.scm")
(load "../4.1/4.06.scm") ;let
(load "../4.1/4.07.scm") ;let*
(load "../4.2/4.26.scm")
(load "prime.scm")
(load "4.50.scm") ;ramb
(load "4.51.scm") ;permanent-set!
(load "4.52.scm") ;if-fail
(load "4.54.scm") ;require

(define input-prompt ";;; Amb-Eval input:")
(define output-prompt ";;; Amb-Eval value:")
(define the-global-environment (setup-environment))

(define (driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input input-prompt)
    (let ((input (read)))
      (if (eq? input 'try-again)
          (try-again)
          (begin
            (newline)
            (display ";;; Starting a new problem")
            (ambeval input
                     the-global-environment
                     ; ambeval success
                     (lambda (val next-alternative)
                       (announce-output output-prompt)
                       (user-print val)
                       (internal-loop next-alternative))
                     ; ambeval failure
                     (lambda ()
                       (announce-output ";;; There are no more values of")
                       (user-print input)
                       (driver-loop)))))))
  (internal-loop
   (lambda ()
     (newline)
     (display ";;; There is no current problem")
     (driver-loop))))

(define (prompt-for-input string)
  (newline)
  (newline)
  (display string)
  (newline))

(define (announce-output string)
  (newline)
  (display string)
  (newline))

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))

(driver-loop)