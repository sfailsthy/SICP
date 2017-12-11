(load "huffman-generate.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (define (iter remain-leaf-set)
    (if (= 1 (length remain-leaf-set))
        remain-leaf-set
        (let ((x1 (car remain-leaf-set))
              (x2 (cadr remain-leaf-set)))
          (iter (adjoin-set (make-code-tree x1 x2)
                            (cddr remain-leaf-set))))))
  (car (iter leaf-set)))