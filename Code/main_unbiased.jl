using Random
using StatsBase
using Distributions

function get_hillNumbers(pp, qV)
    # calculation of Hill numbers of order q
    n = length(pp)
    p = values(countmap(pp)) ./ n # relative frequencies of variants in pp

    hillNumb = zeros(length(qV))
    for i in eachindex(qV)
        if qV[i] == 1.
            hillNumb[i] = exp(-sum(p .* log.(p)))
        else
            hillNumb[i] = sum(p .^ qV[i]) ^ (1 / (1 - qV[i])) # calculation of Hill number of order i -> not defined for q = 1
        end
    end

    return hillNumb
end

function burn_in(nPop, pMut)
    # burn-in period (idea: each variant has undergone neutral dynamic)
    pop = collect(1:nPop) # initial population (every individual has a different variant)
    valueMut = nPop # counter of innovated variant
    while minimum(pop) < nPop + 1  # no variant that was initially present is in the population
        nMut = rand(Binomial(nPop, pMut))  # number of innovations
        pop[1:nPop-nMut] = sample(pop, nPop - nMut, replace=true)  # sampling from the previous generation
        pop[nPop-nMut+1:nPop] = (valueMut+1):(valueMut+nMut)  # adding innovations
        valueMut += nMut  # updating the counter of innovations
    end
    return pop
end

nPop = 10^4  # population size
nSample = 100  # sample size
pMut = 0.001  # innovation rate

qV = collect(0:0.25:3)  # order of Hill numbers to be calculated
qHill = zeros(1, length(qV))
qHillSample = zeros(1, length(qV))

pop = burn_in(nPop, pMut) # neutral population at equilibrium
qHill = get_hillNumbers(pop,qV)  # diversity profile of the population at equilibrium
sampleV = sample(pop, nSample, replace = false) # take a random sample from the population at equilibrium
qHillSample = get_hillNumbers(sampleV, qV)  # diversity profile of the sample at equilibrium
