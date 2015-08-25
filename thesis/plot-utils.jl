using PyPlot

# Plot a histogram with the area under the graph normalized to 1 over all
# samples
function plot_histogram(samples, range; bins=200, label="Samples", lw=3)
    # Select samples, that are in range
    inrange = filter(s -> range[1] <= s <= range[2], samples)

    binedges = linspace(range[1], range[2], bins + 1)
    histogram = hist(inrange, binedges)[2]

    # Normalize to 1 over range
    w = (range[2] - range[1]) / bins
    histogram = histogram / (w * sum(histogram))

    # Normalize to 1 over all samples, so that it is congruent with the real PDF
    N = length(samples)
    n = length(inrange)
    histogram = histogram * (n / N)

    X = linspace(range[1], range[2], bins)
    plot(X, histogram, label=label, lw=lw)
end
