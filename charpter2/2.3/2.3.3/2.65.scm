(load "2.62.scm")
(load "2.63.scm")
(load "2.64.scm")
(load "order-set.scm")

(define (union-tree tree1 tree2)
  (list->tree (union-set (tree->list tree1)
                         (tree->list tree2))))

(define (intersection-tree tree1 tree2)
  (list->tree (intersection-set (tree->list tree1)
                         (tree->list tree2))))