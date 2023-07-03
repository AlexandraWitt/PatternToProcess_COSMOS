# Calculation of Hill numbers 
get_hillNumbers <- function(pp, qV) {
  n <- length(pp)
  uniqueV <- unique(pp) # unique variants in pp
  p <- tabulate(match(pp, uniqueV)) # frequency of unique variants 
  p <- p / n
  
  hillNumb <- rep(0, length(qV))
  
  for (i in 1:length(qV)) {
    q <- qV[i]
    hillNumb[i] <- sum(p^q)^(1 / (1 - q)) # calculation of Hill numbers of order q -> but not defined for q=1
    if (q == 1) {
      hillNumb[i] <- exp(-sum(p*log(p)))
    }
  }
  return(hillNumb)
}

nPop <- 10^4  # population size
nSample <- 100  # sample size
pMut <- 0.001  # innovation rate

qV <- c(seq(0, 3, 0.25))  # order of Hill numbers to be calculated 
qHill <- matrix(0, nrow = 1, ncol = length(qV))
qHillSample <- matrix(0, nrow = 1, ncol = length(qV))

popIni <- 1:nPop  # initial population (every individual has a different variant)
valueMut <- nPop

pop <- popIni
while (min(pop) < nPop + 1) {
  nMut <- rbinom(1, nPop, pMut) # number of innovations 
  pop[1:(nPop - nMut)] <- sample(pop, nPop - nMut, replace = TRUE) # sampling from previous generation 
  pop[(nPop - nMut + 1):nPop] <- (valueMut + 1):(valueMut + nMut) # adding of innovations 
  valueMut <- valueMut + nMut # updating counter of innovations 
}

qHill <- get_hillNumbers(pop, qV) # diversity profile of neutral population at equilibrium

sampleV <- sample(pop, nSample, replace = FALSE) # take random sample from population 
qHillSample <- get_hillNumbers(sampleV, qV) # diversity profile of the neutral sample at equilibrium 

