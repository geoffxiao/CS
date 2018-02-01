#lang racket

(require racket/contract)
(require rackunit)
(require rackunit/text-ui)

(define (binzero? a)
  (null? a))

(define zero '())

(define one '(1))

; (binadd cin a b) adds two binary numbers with a potential carry
; Inputs: cin = 0 or 1, a and b are normalized binary numbers
; Output: a normalized binary number = a + b + cin.
;
; Note: cin is needed for recursive calls when a carry, cout, is
; introduced.
;

; result of current bit
; carry + a + b
(define (result c a b)
  (remainder (+ c a b) 2)
  )

; what is the carry?
; carry is not a binary
; 1 + 1 + 1, carry is 1
; 1 + 1 + 0, carry is 1
; 1 + 0 + 0, carry is 0
; 0 + 0 + 0, carry is 0
(define (carry c a b)
  (if (> (+ a b c) 1)
      1
      0
      )
  )


(define (binadd cin a b)
  (cond
    [(and (binzero? a) (binzero? b))
     (if (= cin 0) ; cin is not a binary
         zero
         one
         )
     ] ; both a and b are 0, result is 0 + 0 + cin = cin
    [(binzero? a) (cons (result cin 0 (first b))
                     (binadd (carry cin 0 (first b)) '() (rest b))
                     )] ; 0 + b' + cin = b' + cin
    [(binzero? b) (cons (result cin (first a) 0)
                     (binadd (carry cin (first a) 0) (rest a) '())
                     )] ; a' + 0 + cin = a' + cin
    [else (cons (result cin (first a) (first b))
                (binadd (carry cin (first a) (first b)) (rest a) (rest b))
                )] ; a' + b' + cin
    )
  )


; Unit tests - tests binadd.
(define-test-suite binadd-suite

  (check-equal? 
    (binadd 0 '() '()) '())
  
  (check-equal? 
    (binadd 1 '() '()) '(1))

  (check-equal? 
    (binadd 0 '() '(1 0 1)) '(1 0 1))

  (check-equal? 
    (binadd 0 '(1 0 1) '()) '(1 0 1))

  (check-equal? 
    (binadd 1 '() '(1 0 1)) '(0 1 1))
  
  (check-equal? 
    (binadd 1 '(1 0 1) '()) '(0 1 1))

  (check-equal? 
    (binadd 0 '(1) '(1 1 1)) '(0 0 0 1))

  (check-equal? 
    (binadd 0 '(1 1 1) '(1)) '(0 0 0 1))

  (check-equal? 
    (binadd 0 '(1 0 1) '(0 1 1)) '(1 1 0 1))
  
  (check-equal? 
    (binadd 0 '(1 1 1) '(1 1 1)) '(0 1 1 1))

)
(print "Running binadd tests")  (newline)
(run-tests binadd-suite 'verbose)


;----------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------------------------------------------------------;


; (binmult2 h b) multiplies a binary number by a power of two
; Inputs:  h a non-negative integer and b a binary number.
; Output: a binary number equal to 2^h*b
;
; Note: multiplication of a binary number by a power of two is
; just a shift, where h leading zeros are inserted before the trailing
; bit of the binary number.

; multiply b * 2 h times
; cons 0 to mult by 2
(define (binmult2 h b)
  (if (= h 0)
      b
      (cons 0 (binmult2 (- h 1) b))
      )
  )

; (binmult h a b) computes the product of two binary numbers multiplied
; by a power of two.
; Inputs: h a non-negative integer, a and b normalized binary numbers.
; Output: a normalized binary number equal to 2^h*a*b.
;
; Note: Let a = (a_0 a_1 ... a_{m-1}).  The following recursive construction
; is used, which shows why the parameter h is included.
; a*b = a_0*b + 2*(a_1 ... a_{m-1})*b

; result of single bit * binary number
(define (result-mult a b)
  (if (= a 0)
      '()
      b
      )
  )

(define (binmult a b)
  (cond
    [(binzero? a) zero] ; a = 0, return 0
    [(binzero? b) zero] ; b = 0, return 0
    [else (binadd 0 (result-mult (first a) b) ; else 0 + current bit * b + rest of a * b
                  (binmult2 1 (binmult (rest a) b)))]
    )
  )


; Unit tests - tests binmult.
(define-test-suite binmult-suite
  
  (check-equal? 
    (binmult2 0 '(1 0 1)) '(1 0 1))

  (check-equal? 
    (binmult2 3 '(1 0 1)) '(0 0 0 1 0 1))

  (check-equal? 
    (binmult zero '(1 0 1)) zero)

  (check-equal? 
    (binmult '(1 0 1) zero) zero)

  (check-equal? 
    (binmult one '(1 0 1)) '(1 0 1))

  (check-equal? 
    (binmult '(1 0 1) one) '(1 0 1))
  
  (check-equal? 
    (binmult '(0 0 1) '(1 0 1)) '(0 0 1 0 1))

  (check-equal? 
    (binmult '(1 0 1) '(0 0 1)) '(0 0 1 0 1))

  (check-equal? 
    (binmult '(1 0 1) '(1 0 1)) '(1 0 0 1 1))
)
(print "Running binmult tests")  (newline)
(run-tests binmult-suite 'verbose)
