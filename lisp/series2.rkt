;; racket seriea2.rkt

#lang racket

(define (series x acc)
  (if (= x 0)
    acc
	(series (- x 1) (+ acc x)))
)

(series 10 0)
;;(series 1000000000 0) ;; OK
