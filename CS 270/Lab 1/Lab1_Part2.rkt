#lang racket
(define (add1 x) (+ x 1))

(define (fact n)
  (if (= n 0)
      1
      ( * n (fact (- n 1)) )
   )
)

(fact 10)
(fact (fact 4))
(fact 0)