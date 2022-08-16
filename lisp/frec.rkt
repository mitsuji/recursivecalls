;; racket frec.rkt

#lang racket

(define (frec x)
  (println x)
  (frec (+ x 1)))

(frec 0)