(define (always-true ignore frame-stream) frame-stream)

(put 'always-true 'qeval always-true)