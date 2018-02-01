#lang racket

;--------------------------------------------------------------------------;
; Question 1
(define (map_lab f L)
  (if
    (null? L) '() ; return nothing
    (cons (f (first L)) (map_lab f (rest L))) ; else add f( first element of L ) to map f rest of L
    )
  )

; Testing :)
(define L-1 '(1 2 3 4 5 6))
(define f1 sqr)

(equal? (map f1 L-1) (map_lab f1 L-1))


;--------------------------------------------------------------------------;
; Question 2
(define (reduce f init L)
  (if
    (null? L) init ; empty list, return init value
    (f (first L) (reduce f init (rest L))) ; else recursion :)
    )
  )

; Tail recursion implementation of Question 2??? Is it possible?

(define f2 +)
(equal? (reduce f2 0 L-1) (foldr f2 0 L-1))


;--------------------------------------------------------------------------;
; Question 3
; is-negative? x
;   if x < 0, returns 1
;   else return 0

; characteristic function
;  predicate -> 0/1 instead of t/f
(define (is-negative? x)
  (if (< x 0)
      1
      0
      )
  )

(define L-3 '(1 2 -1 -2 -1 2 -1 -100 0))
(reduce + 0 (map is-negative? L-3)) ; number of negatives: apply is-negative? and then sum it all up

;--------------------------------------------------------------------------;
; Question 4

; base case = 3
; vvv, vhh, hhv

; base case = 2
; vv, hh

; add base case solutions
(define (base-case-n-3 L)
  (append
   (map (lambda (x) (string-append "vvv" x)) L)
   (map (lambda (x) (string-append "vhh" x)) L)
   (map (lambda (x) (string-append "hhv" x)) L)
   )
  )
(define (base-case-n-2 L)
  (append
   (map (lambda (x) (string-append "vv" x)) L)
   (map (lambda (x) (string-append "hh" x)) L)
   )
  )
(define (base-case-n-1 L)
  (append
   (map (lambda (x) (string-append "v" x)) L)
   )
  )

(define (base-case-n-0 L)
  (append
   (map (lambda (x) (string-append "" x)) L)
   )
  )

; n - 1 recursion call, append v
(define (v-case L)
  (append
   (map (lambda (x) (string-append "v" x)) L)
   )
  )

; n - 2 recursion call, append hh
(define (hh-case L)
  (append
   (map (lambda (x) (string-append "hh" x)) L)
   )
  )

; helper function
(define (GenDominoes-helper n result)
  (cond
    ;[(eq? n 3) (base-case-n-3 result)] ; base case
    ;[(eq? n 2) (base-case-n-2 result)] ; base case
    [(eq? n 1) (base-case-n-1 result)] ; base case
    [(= n 0) result] ; base case
    [else (append (GenDominoes-helper (- n 1) (v-case result))
                  (GenDominoes-helper (- n 2) (hh-case result)) )
          ] ; combine the results from n-1 and n-2 recursive calls
      )
  )

; main function
(define (GenDominoes n)
  (GenDominoes-helper n '(""))
  )

; test
(length (GenDominoes 1))
(length (GenDominoes 2))
(length (GenDominoes 3))
(length (GenDominoes 4))
(length (GenDominoes 5))
(length (GenDominoes 6))
(length (GenDominoes 7))
(length (GenDominoes 8))
(length (GenDominoes 9))
(length (GenDominoes 10))

; fibonacci sequence
; https://content.ncetm.org.uk/images/microsites/secondary_magazine/issue_72/72_21.gif
; Wow!!