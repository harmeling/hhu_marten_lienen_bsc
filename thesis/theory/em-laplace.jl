import Transforms: RandomVariable
import Distributions: Laplace, pdf

using PyPlot

X = linspace(-1, 5, 200)

samples = 10000
a = Laplace(1, 2)
b = RandomVariable(a, samples, 10)

plot(X, pdf(a, X), label="Laplace", lw=3)
plot(X, pdf(b.distribution, X), label="Mixture", lw=3)

legend()
savefig("em-laplace.png")
