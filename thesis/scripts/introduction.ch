(define (sample)
  (define x1 (gaussian 1 1))
  (define x2 (gamma 1 1))
  (define y (exponential 1))

  (/ (+ x1 x2) y))

(define samples (repeat 100000 sample))

(for-each display (map stringify samples))
""
