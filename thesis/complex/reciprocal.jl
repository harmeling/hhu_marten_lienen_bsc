import Transforms
import Distributions: MixtureModel, Normal, Uniform, pdf

using PyPlot

include("../plot-utils.jl")

onemodel = Uniform(0.95, 1.05)
xmodel = MixtureModel([Normal(1., 2.), Normal(-4., 10.)], [0.5, 0.5])

components = 10
n = 10000

alg = Transforms.GaussHermiteQuadrature(1000)
one = Transforms.RandomVariable(onemodel, n, components)
x = Transforms.RandomVariable(xmodel, alg)

y = one / x

range = (-10, 10)
X = linspace(range[1], range[2], 200)

plot(X, pdf(xmodel, X), label="X", lw=3)
legend()
savefig("reciprocal-x.png")
clf()

range = (0, 2)
X = linspace(range[1], range[2], 200)

plot(X, pdf(onemodel, X), label="Uniform", lw=3)
plot(X, pdf(one.distribution, X), label="Mixture", lw=3, alpha=0.8, color="red")
legend()
savefig("reciprocal-one.png")
clf()

range = (-1, 1)
X = linspace(range[1], range[2], 200)

n = 100000
samples = rand(xmodel, n).^(-1)

plot_histogram(samples, range)
plot(X, pdf(y.distribution, X), label="1/x", lw=3)
legend()
savefig("reciprocal-result.png")
clf()
