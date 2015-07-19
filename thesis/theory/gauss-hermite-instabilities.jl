import Transforms: RandomVariable
import Distributions: MixtureModel, Normal, pdf
import FastGaussQuadrature: gausshermite

using PyPlot

include("../plot-utils.jl")

range = (-10, 10)
n = 200
X = linspace(range[1], range[2], n)

amodel = MixtureModel([Normal(1, 1), Normal(3, 1)], [0.5, 0.5])
bmodel = MixtureModel([Normal(1, 1), Normal(-2, 3), Normal(-2, 0.5)],
                      [0.2, 0.6, 0.2])

alg = Transforms.GaussHermiteQuadrature(600)
a = RandomVariable(amodel, alg)
b = RandomVariable(bmodel, alg)
c = a * b

cc = c.distribution.components
cc = sort(cc, by=Distributions.var)
cc = cc[1:10]

N = 1000000
samples = rand(amodel, N) .* rand(bmodel, N)

figure(num=1, figsize=(4, 3))

plot_histogram(samples, range, bins=n)
plot(X, pdf(c.distribution, X), label="Mixture", lw=3, alpha=0.8, color="red")

for c = cc
    plot(c.μ, c.σ, "o", lw=3)
end

legend()
savefig("gauss-hermite-instabilities.png")
