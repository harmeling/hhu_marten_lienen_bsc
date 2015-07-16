import Transforms: RandomVariable
import Distributions: Chisq, pdf

using PyPlot

X = linspace(-1, 5, 200)

samples = 30000
a = Chisq(3)
b = RandomVariable(a, samples, 15)

plot(X, pdf(a, X), label="Chi Square", lw=3)
plot(X, pdf(b.distribution, X), label="Mixture", lw=3)

legend()
savefig("em-chisq.png")
