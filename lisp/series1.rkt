;; racket series1.rkt

#lang racket

(define (series x)
  (if (= x 0)
    0
	(+ x (series (- x 1))))
)

(series 10)
;;(series 1000000000) ;;強制終了
