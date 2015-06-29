(define (mixture-of-normals weights mu sigma)
  (define component (+ 1 (sample-discrete weights)))

  (gaussian (list-elt mu component)
            (list-elt sigma component)))

(define a-weights (list 0.2 0.3 0.1 0.4))
(define a-mu (list 0 -1 -1.1 2))
(define a-sigma (list 1 1 5 1.2))

(define b-weights (list 0.5 0.25 0.25))
(define b-mu (list 3 2 -5))
(define b-sigma (list 10 0.2 1.2))

(define (sample)
  (define a (mixture-of-normals a-weights a-mu a-sigma))
  (define b (mixture-of-normals b-weights b-mu b-sigma))

  (+ a b))

(define samples (repeat 100000 sample))

(for-each display (map stringify samples))
""
