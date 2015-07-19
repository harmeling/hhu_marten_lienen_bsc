import Distributions: Cauchy

include("em.jl")

a = Cauchy(-2, 1)

plotem(a, [2, 5], "cauchy", "Cauchy")
