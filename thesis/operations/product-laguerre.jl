import Transforms
import Distributions: MixtureModel, Normal, pdf

include("../plot-utils.jl")

amodel = MixtureModel([Normal(1., 2.), Normal(-4., 10.)], [0.5, 0.5])
bmodel = MixtureModel([Normal(1., 2.), Normal(-4., 10.), Normal(2.3, 0.3)],
                      [0.2, 0.5, 0.3])

n = 10000000
range = (-10, 10)
X = linspace(range[1], range[2], 400)

plot(X, pdf(amodel, X), label="a", lw=3)
plot(X, pdf(bmodel, X), label="b", lw=3)
legend()
savefig("product-laguerre-vars.png")
clf()

samples = map(*, rand(amodel, n), rand(bmodel, n))

for ϵ = [0, 5, 10]
    alg = Transforms.GaussLaguerreQuadrature(100, ϵ / 100)
    a = Transforms.RandomVariable(amodel, alg)
    b = Transforms.RandomVariable(bmodel, alg)
    c = a * b

    plot_histogram(samples, range, bins=400)
    plot(X, pdf(c.distribution, X), label="a * b",
         lw=3, alpha=0.8, color="red")
    legend()
    savefig("product-laguerre-$ϵ.png")
    clf()
end
