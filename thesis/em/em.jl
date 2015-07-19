import Transforms: RandomVariable
import Distributions: pdf

using PyPlot

function plotem(a, components, file, label; samples=3000, range=(-10, 10))
    n = 200
    X = linspace(range[1], range[2], n)

    for i = components
        b = RandomVariable(a, samples, i)

        plot(X, pdf(a, X), label=label, lw=3)
        plot(X, pdf(b.distribution, X), label="$i components", lw=3, alpha=0.8)
        legend()
        savefig("$file-$i-components.png")
        clf()
    end
end
