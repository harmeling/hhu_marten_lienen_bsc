import Transforms: RandomVariable
import Distributions: MixtureModel, Normal, pdf

include("../plot-utils.jl")

amodel = MixtureModel([Normal(1, 2), Normal(-3, 1)], [0.5, 0.5])
bmodel = MixtureModel([Normal(10, 10), Normal(2, 1), Normal(-3, 4)],
                      [0.3, 0.1, 0.6])
cmodel = MixtureModel([Normal(0, 1), Normal(-1, 0.5)], [0.7, 0.3])

a = RandomVariable(amodel)
b = RandomVariable(bmodel)
c = RandomVariable(cmodel)

f(a, b, c) = 3 * a / 5 + 2 * b - c - 3

n = 10000000
range = (-10, 10)
X = linspace(range[1], range[2], 400)

plot(X, pdf(amodel, X), label="a", lw=3)
plot(X, pdf(bmodel, X), label="b", lw=3)
plot(X, pdf(cmodel, X), label="c", lw=3)
legend()
savefig("affine-vars.png")
clf()

d = f(a, b, c)
samples = map(f, rand(amodel, n), rand(bmodel, n), rand(cmodel, n))

plot_histogram(samples, range, bins=400)
plot(X, pdf(d.distribution, X), label="f(a, b, c)",
     lw=3, alpha=0.8, color="red")
legend()
savefig("affine-result.png")
clf()
