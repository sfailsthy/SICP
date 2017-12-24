(load "analyze.scm")
(load "analyze-application.scm")
(load "analyze-assignment.scm")
(load "analyze-definition.scm")
(load "analyze-if.scm")
(load "analyze-lambda.scm")
(load "analyze-quoted.scm")
(load "analyze-self-evaluating.scm")
(load "analyze-sequence.scm")
(load "analyze-variable.scm")
(load "application.scm")
(load "assignment.scm")
(load "begin.scm")
(load "cond.scm")
(load "definition.scm")
(load "environment.scm")
(load "eval.scm")
(load "if.scm")
(load "lambda.scm")
(load "predicate.scm")
(load "primitive-procedure.scm")
(load "procedure.scm")
(load "quote.scm")
(load "self-evaluating.scm")
(load "tagged-list.scm")
(load "setup-environment.scm")
(load "variable.scm")
(load "4.22.scm")

(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval output:")
(define the-global-environment (setup-environment))

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

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
                     (prcedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))