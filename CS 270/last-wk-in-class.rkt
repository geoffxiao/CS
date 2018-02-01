(define (reverse L)
  (if (null? L)
      null
      (append (reverse (rest L)) (cons (first L) null))
      )
  )

; Property 1
(list? L) -> (list? (reverse L))
; can't test by showing all possible lengths of L
; using mathematical induction to prove for any list L

; Base Case: L = '()
(list? '()) -> (list? (reverse '()))
; By definition of reverse:
(reverse '()) = '()
(list '()) -> (list? '())

; Inductive Case
; Assume (list? B) = #t and (list? (reverse B)) = #t
; Assume a is a value
(list? (reverse (cons a B)))
(reverse (cons a B))
= (if (null? (cons a B))
    null
    (append (reverse (rest (cons a B)) (cons (first L) null)))
    )
= (if #f
      null
      (append (reverse (rest (cons a B)) (cons (first L) null)))
      )
= (append (reverse (rest (cons a B)) (cons (first L) null)))
= (append (reverse B) (cons a null)) = (append (reverse B) (a))

(list? (reverse B)) = #t by IH
(list? (a)) = #t by definition of list?

; Using property 1 of append
(and list? (reverse B) AND (list? (a))) = #t -> (list? append (reverse B) a)

; the inductive proof is complete


; Property 2
(length (reverse L)) = (length L)

; Base Case: L = '()
(reverse '()) = '() ; prove this line by plugging in the definition of reverse...equational reasoning
(length (reverse L)) = (length '()) = (length '()) = 0

; IH
; Assume list B such that (list? B) = #t, (length B) = n, (length (reverse B)) = n

; IP
; let a be an atom
(length (cons (a B))) = (length (reverse (cons a B)))

(reverse (cons a B)) = (append (reverse B) (a)) ; from the proof in property 1
(length (append (reverse B) (a))) = (+ (length (reverse B)) (length a)) ; from property 5 of append
(+ (length (reverse B)) (length a)) = (+ n (length '(a))) ; IP
(+ n (length '(a))) = (+ n 1) ; from a being an atom

(length (cons (a B)) = (+ 1 (length B)) ; from definition of length
(+ 1 (length B)) = (+ 1 n) ; from IH


; Property 3
(reverse (append x y)) = (append (reverse y) (reverse x))

; x = '()



; IH x = B
(reverse (append B y)) = (append (reverse y) (reverse B))

; IP
(reverse (append (cons a B) y))
(append (cons a B) y) = (append (append '(a) B) y) = (append '(a) (append B y))
(append '(a) (append B y)) = (cons a (append B y))

(reverse (cons a (append B y))) =
(append (reverse (rest (cons a (append B y)))) (cons (first (cons a (append B y))) null))
(append (reverse (append B y)) (cons a null)) =
(append (append (reverse y) (reverse B)) (cons a null)) =
(append (reverse y) (append (reverse B) (cons a null))) = ; Property 5 of append
(append (reverse y) (reverse (cons a B)))

(reverse (append (cons a B) y)) = (append (reverse y) (reverse (cons a B)))

; Property 4
(reverse (reverse x))

; Base Case: x = '()
(reverse (reverse '())) = (reverse '()) ; by previous proofs
(reverse '()) = '() ; by previous proofs

; IH
(reverse (reverse B)) = B

; IP
(reverse (reverse (cons a B)))
(reverse (cons a B)) = (append (reverse (rest (cons a B))) (cons (first (cons a B)) null))
(append (reverse (rest (cons a B))) (cons (first (cons a B)) null)) = (append (reverse B) '(a))

(reverse (append (reverse B) '(a))) = (append (reverse '(a)) (reverse (reverse B))) ; by Property 3 of reverse

(append (reverse '(a)) (reverse (reverse B))) = (append '(a) (reverse (reverse B))) = (append '(a) B) = (cons a B) ; NICE :)


(reverse '(a)) = (if (null? '(a)
                            null
                            (append (reverse (rest '(a))) (cons (first '(a)) null))
                            )
                     ) =
                       (append (reverse '()) '(a)) = '(a)

                     