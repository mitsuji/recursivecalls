#lang racket

(define (series1 x)
  (if (= x 0)
    0
	(+ x (series1 (- x 1))))
)

;(series1 100000000)


(define (series2 x acc)
  (if (= x 0)
    acc
	(series2 (- x 1) (+ acc x)))
)

(series2 100000000 0)


(define (loop x)
  (println x)
  (loop (+ x 1)))

;(loop 0)