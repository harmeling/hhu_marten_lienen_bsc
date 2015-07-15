(define (sample)
  (define x1 (gaussian 1 2))
  (define x2 (gamma 1 3))
  (define y (exponential 2))

  (/ (* x1 x2) y))

(define samples (repeat 100000 sample))

(for-each display (map stringify samples))
""
