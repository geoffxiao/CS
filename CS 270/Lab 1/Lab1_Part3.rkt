#lang racket

#|
Lab 1:  Introduction to Racket and unit testing in Racket
CS 270 (Math Foundations of CS)

Before beginning this lab you should have installed DrRacket.  You
should also take a few minutes to review the functions in this file
so that you understand what they are supposed to do and how to run
unit tests in Racket.

Next open DrRacket and load this file (select Open in the File menu)
into DrRacket and answer the embedded questions in the definition panel
of DrRacket. After answering each question, click the Run button to
check your answer.  If you made a mistake, you should make the
appropriate changes and click the Run button again.

After you load this file into DrRacket and before you start answering
the questions, click the Run button.  You should see the following
summary from running the unit tests in member-suite.

3 success(es) 0 failure(s) 0 error(s) 3 test(s) run
0

|#

(require racket/contract)
(require rackunit)
(require rackunit/text-ui)

; (atom? x)
; Input: x is an arbitrary racket S expression
; Output: A boolean equal to #t if x is an atom and #f otherwise

(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

; (member? a lat)
; Inputs: a is an atom and lat is a list of atoms.
; Output: A boolean equal to #t if a is in lat and #f otherwise
; Note:  member? is similar to the function of the same name in
;        chapter 2 of the Little Schemer.  The only difference
;        is that three cases are used in the cond expression instead
;        of two.

(define member?
  (lambda (a lat)
    (cond
      [(null? lat) #f]
      [(eq? (first lat) a) #t]
      [else (member? a (rest lat))])))

; Unit tests - tests member?.
(define-test-suite member-suite

  (check-equal? 
    (member? 'x '(x a b c)) #t)
  
  (check-equal? 
    (member? 'x '(a b c x)) #t)

    (check-equal? 
    (member? 'x '(a b c)) #f)
)
(run-tests member-suite 'verbose)

#|
Question 1
Define alt-member? which has the same specification as member? but is
implemented using two cases rather than 3 as in the Little Schemer.
Use an or expression to combine the last two cases.  Does the order of
the inputs to the or function matter?  Create and run a unit test similar
to member-suite that tests alt-member?  Why is it equivalent to the
version above?  
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
The order of the inputs to the or function does not matter.
If the first statement is #t, the entire statement is #t.
If the first statement is #f, the second statement determines the value of the statement.

The test suite is the same as member? because both member? and alt-member?
test different implementations of the same function.
|#

(define alt-member?

  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)) (alt-member? a (cdr lat)))
    )
  )
)

(define-test-suite alt-member-suite

  (check-equal? 
    (alt-member? 'x '(x a b c)) #t)
  
  (check-equal? 
    (alt-member? 'x '(a b c x)) #t)

    (check-equal? 
    (alt-member? 'x '(a b c)) #f)
)
(run-tests alt-member-suite 'verbose)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
Question 2
An environment is a list of bindings where a binding is a pair - list
of length 2 - that associates a value with variable.  A variable in Racket
is a symbol which can be detected with the symbol? predicate.  E.G.
(symbol? 'x) = #t and (symbol? 3) = #f.

Here is an example environment:  ((x 2) (y 3) (z #f))

Define a recursive function called lookup which given a variable and
an environment returns the associated value if the given variable is
in the environment.

E.G. (lookup 'y '((x 2) (y 3) (z #f))) => 3

If var is not in the environment use the built-in function
(error sym message) to indicate an error has occured.
(error sym message) takes takes a symbole sym and a string message
and raises and exception which prints an error message
E.G. (error var "not found").

To make your code easier to read and independent of low level
data structures, implement and use the helper functions

(define (get-var-in-binding b) ...)

(define(get-val-in-binding b) ...)

which return the variable and value respectively in a binding.

Write and run a unit test to test your code. Call lookup with a
variable that is not in env.  Why can't you include such cases in
your unit test?
|#

; (get-var-in-binding b)
; Inputs: b = (var val) a binding
; Output: var the variable in b

; (get-val-in-binding b)
; Inputs: b = (var val) a binding
; Output: val the value in b

; (lookup? var env)
; Inputs: var is a variable, which is a Racket symbol, and env is an
;         environment.
; Output: if var occurs in a binding in env, then the S-expression
;         associated with var is returned.
;         if var does not occur in a binding in env an error is thrown
;         using the built-in error function.


(define get-var-in-binding
  ( lambda (b)
     (if (eq? 2 (length b)) (first b) ; if a binding, return the first part of binding
         (error 'b "Error: Not a Binding")
         )
     )
  )


; Test get-var-in-binding
(define-test-suite get-var-in-binding-suite

  (check-equal? 
    (get-var-in-binding '(x a)) 'x)

)
(run-tests get-var-in-binding-suite 'verbose)


(define get-val-in-binding
  ( lambda (b)
     (if (eq? 2 (length b)) (first (cdr b)) ; if a binding, return the second part of binding
         (error 'b "Error: Not a Binding")
         )
     )
  )


; Test get-val-in-binding
(define-test-suite get-val-in-binding-suite

  (check-equal? 
    (get-val-in-binding '(x a)) 'a)

)
(run-tests get-val-in-binding-suite 'verbose)


(define lookup?
  (lambda (var env)
    (cond
      ((not (symbol? var))
       (error 'var "Error: var is not a symbol"))
      ((null? env)
       (error 'var "Error: var not in env"))
      ((eq? var (get-var-in-binding (first env))); is var in first binding?
       (get-val-in-binding (first env))) ; then return the value
      (else
       (lookup? var (rest env))) ; else check the rest of the binding
      )
    )
  )

(define-test-suite lookup-suite

  (check-equal? 
    (lookup? 'y '((x 2) (y 3) (z #f))) 3)

  (check-equal? 
   (lookup? 'x '((x 2) (y 3) (z #f))) 2)

  (check-equal? 
   (lookup? 'z '((x 2) (y 3) (z #f))) #f)

  (check-equal? 
   (lookup? 'bob '((x 2) (y 3) (z #f) (l 0) (p 1) (bob 100))) 100)

)
(run-tests lookup-suite 'verbose)

; We cannot test a case when the var is not in env:
; (lookup? 'g '((x 2) (y 3) (z #f)))
; because we throw an error when var is not in env