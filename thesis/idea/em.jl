import Transforms: RandomVariable
import Distributions: Gamma, pdf

using PyPlot

X = linspace(-1, 5, 200)

samples = 10000
a = Gamma(1, 2)

plot(X, pdf(a, X), label="Gamma(a = 1, b = 2)", lw=3)

for i = [2, 5, 10]
    b = RandomVariable(a, samples, i)

    plot(X, pdf(b.distribution, X), label="Mixture with $i components", lw=3)
end

legend()
savefig("em.png")
