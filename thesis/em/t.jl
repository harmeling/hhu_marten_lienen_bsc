import Distributions: TDist

include("em.jl")

a = TDist(3)

plotem(a, [2, 5], "t", "Student's T", range=(-6, 6))
