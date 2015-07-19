import Distributions: Weibull

include("em.jl")

a = Weibull(1, 1.5)

plotem(a, [5, 10], "weibull", "Weibull", range=(-1, 6))
