; Lemma 1
(and (is-dnf? exp1) (is-dnf? exp2)) ->
(is-dnf? (list 'or exp1 exp2))

; Assume (is-dnf? exp1), (is-dnf? exp2)
(is-dnf? (list 'or exp1 exp2))
= (and (is-nnf? (list 'or exp1 exp2)) (no-and-above-or? (list? 'or exp1 exp2))) ; by definition of is-dnf?

(is-nnf? (list 'or exp1 exp2)) = (and (is-nnf? (op1 (list 'or exp1 exp2)) (is-nnf? (op2 (list 'or exp1 exp2))))) ; by definition of is-nnf?
= (and (is-nnf? exp1) (is-nnf? exp2)) = #t by assumption


(no-and-above-or? (list? 'or exp1 exp2)) = (and (no-and-above-or? (op1 (list 'or exp1 exp2))) (no-and-above-or? (op2 (list 'or exp1 exp2))))
= (and (no-and-above-or? exp1) (no-and-above-or? exp2))
= #t ; by assumption

; proof is complete!!



; Lemma 2
(and (is-dnf? e1) (is-dnf? e2)) -> (is-dnf? (distrib-andor e1 e2))

; Assume
(is-dnf? e1)
(is-dnf? e2)

; look at distrib-andor
; 3 Cases for distrib-andor
; Case 1
(distrib-andor '(or x y) z) = (list 'or (distrib-andor x z) (distrib-andor y z))

; Case 2
(distrib-andor x '(or y z)) = (list 'or (distrib-andor x y) (distrib-andor x z))

; Case 3
(distrib-andor x y) = (list 'and x y)


; To get into case 3, let us assume the following
; exp1 doesn't start with an or
; exp2 doesn't start with an or
; (and (is-dnf? e1) (is-dnf? e2)) = #t
; exp1 has no ors, exp2 has no ors from these 3 assumptions

(is-dnf? (distribandor e1 e2)) = (is-dnf? (list 'and e1 e2))
= (and (is-nnf? (list 'and e1 e2)) (no-and-above-or (list 'and e1 e2))) = #t from assumptions, previous proofs

; Therefore statement is true for Case 3



; Now let us look at Case 1... :o :] :[ :-o :D :P :p :[]
(distrib-andor '(or x y) z) = (list 'or (distrib-andor x z) (distrib-andor y z))

; Assume:
(is-dnf (or x y)) = #t
; from this first assumption, we get
(is-nnf? x) = #t, (is-nnf? y) = #t
(no-and-above-or x) = #t, (no-and-above-or y) = #t

; Assume this
(is-dnf? z) = #t
; therefore, we derive the following
(is-nnf? z) = #t, (no-and-above-or z) = #t

; e1 = x or y and e2 = z
(distrib-andor '(or x y) z) = (list 'or (distrib-andor x z) (distrib-andor y z))

; proof
(is-dnf? (distrib-andor (or x y) z)) =
(is-dnf? (list 'or (distrib-andor x z) (distrib-andor y z))) ; by def of distrib-andor
(and (is-dnf? (distrib-andor x z)) (is-dnf? (distrib-andor y z))) ; by def of is-dnf?

; 2 cases -- nnf and no-and-above-or

; Assume, Inductive hypothesis
(and (is-dnf? (distrib-andor x z)) (is-dnf? (distrib-andor y z)))

; Inductive proof
(is-dnf? (distrib-andor (or x y) z))

; how is this induction?
; usually assume k, prove k + 1
; how is the IP a "+ 1" of IH?
; relation between IH and IP????

; 3rd case. do you need to assume e2 has no ors???
; prove all 3 cases, proved all scenarios

; WHAT IS ON THIS EXAM??? :(


; Base cases do not make any recursive calls !!
;
;  ! !
; \---/
;





;--------------------------------------------;
; Lab 10
; look at plus-simp
(plus-simp 2 5) = (+ 2 5)

; Case 1
; c1 = constant, c2 = constant
; (+ c1 c2) = c3
(eval (plus-simp c1 c2) env)
= (eval (+ c1 c2) env)
= c3

; to get through all the cases make the appropriate assumptions!! :)
; prove 


