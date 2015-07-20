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
savefig("product-hermite-vars.png")
clf()

samples = map(*, rand(amodel, n), rand(bmodel, n))

for n = [50, 100, 2000]
    alg = Transforms.GaussHermiteQuadrature(n)
    a = Transforms.RandomVariable(amodel, alg)
    b = Transforms.RandomVariable(bmodel, alg)
    c = a * b

    plot_histogram(samples, range, bins=400)
    plot(X, pdf(c.distribution, X), label="a * b",
         lw=3, alpha=0.8, color="red")
    legend()
    savefig("product-hermite-$n-components.png")
    clf()
end
