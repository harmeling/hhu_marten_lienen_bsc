import Distributions: Uniform

include("em.jl")

a = Uniform(-2, 0)

plotem(a, [5, 10], "uniform", "Uniform", range=(-4, 3))
