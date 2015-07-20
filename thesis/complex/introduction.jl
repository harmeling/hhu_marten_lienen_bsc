import Transforms
import Distributions: MixtureModel, Normal, Exponential, Gamma, pdf

using PyPlot

include("../plot-utils.jl")

x1model = Normal(1, 2)
x2model = Gamma(1, 3)
ymodel = Exponential(2)

components = 3
samples = 10000
x1 = Transforms.RandomVariable(x1model, samples, components)
x2 = Transforms.RandomVariable(x2model, samples, components)
y = Transforms.RandomVariable(ymodel, samples, components)

range = (-10, 10)
X = linspace(range[1], range[2], 200)

function plotx(xmodel, x, name)
    plot(X, pdf(xmodel, X), label=name, lw=3)
    plot(X, pdf(x.distribution, X), label="Mixture", lw=3)
    legend()
    savefig("introduction-var-$name.png")
    clf()
end

plotx(x1model, x1, "x1")
plotx(x2model, x2, "x2")
plotx(ymodel, y, "y")

f(x1, x2, y) = (x1 * x2) / y

n = 100000
samples = map(f, rand(x1model, n), rand(x2model, n), rand(ymodel, n))
z = f(x1, x2, y)

plot_histogram(samples, range)
plot(X, pdf(z.distribution, X), lw=3, alpha=0.8, label="Mixture", color="red")
legend()
savefig("introduction-result.png")
clf()
