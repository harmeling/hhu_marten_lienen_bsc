import Distributions: Gamma

include("em.jl")

a = Gamma(2.0, 2.0)

plotem(a, [5, 100], "gamma", "Gamma", range=(-1, 10))
