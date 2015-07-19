import Distributions: Laplace

include("em.jl")

a = Laplace(-3, 2)

plotem(a, [2, 5], "laplace", "Laplace")
