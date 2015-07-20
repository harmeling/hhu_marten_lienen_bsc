import Transforms: RandomVariable
import Distributions: MixtureModel, Normal, pdf

using PyPlot

include("../plot-utils.jl")

range = (-20, 20)
n = 200
X = linspace(range[1], range[2], n)

amodel = MixtureModel([Normal(1, 1), Normal(3, 1)], [0.5, 0.5])
bmodel = MixtureModel([Normal(1, 1), Normal(-2, 3), Normal(-2, 0.5)],
                      [0.2, 0.6, 0.2])

hermite = Transforms.GaussHermiteQuadrature(600)
laguerre = Transforms.GaussLaguerreQuadrature(600, 0.0)
a = RandomVariable(amodel, hermite)
b = RandomVariable(bmodel, hermite)
c = a * b
d = RandomVariable(amodel, laguerre)
e = RandomVariable(bmodel, laguerre)
f = d * e

N = 1000000
samples = rand(amodel, N) .* rand(bmodel, N)

plot_histogram(samples, range, bins=n)
plot(X, pdf(c.distribution, X), label="Gauss-Hermite", lw=3, alpha=0.8, color="red")
plot(X, pdf(f.distribution, X), label="Gauss-Laguerre", lw=3, alpha=0.8, color="green")

legend()
savefig("hermite-laguerre.png")
