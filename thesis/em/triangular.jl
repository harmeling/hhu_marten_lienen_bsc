import Distributions: TriangularDist

include("em.jl")

a = TriangularDist(-2.0, 1.0, -1.5)

plotem(a, [5, 100], "triangular", "Triangular", range=(-4, 2))
