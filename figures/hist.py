#!/usr/bin/env python

import matplotlib.pyplot as plt
import sys

def main():
    input = sys.stdin.readlines()

    # Remove last empty line
    input.pop()

    numbers = list(map(float, input))

    plt.hist(numbers, bins=300)
    plt.savefig(sys.argv[1])

if __name__ == "__main__":
    main()
