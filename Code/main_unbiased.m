clear all
close all

nPop = 10^4; % population size
nSample = 100; % sample size
pMut = 0.001; % innovation rate

qV = [0:0.25:3]; % order of Hill numbers to be calculated
qHill = zeros(1,numel(qV));
qHillSample = zeros(1,numel(qV));

popIni = [1:nPop]; % initial population (every individual has different variant)
valueMut = nPop; % counter of innovated variant

pop = popIni;

%burn-in period (idea: each variant has undergone neutral dynamic)
while min(pop)<nPop+1 % no variant that was initially present is in populatin
    
    nMut = binornd(nPop,pMut); % number of innovations
    
    pop(1:nPop-nMut) = randsample(pop,nPop-nMut,'true'); % sampling from previous generation
    pop(nPop-nMut+1:nPop) = [valueMut+1:valueMut+nMut]; % adding of innovations
    valueMut = valueMut+nMut; % updating counter of innovations
    
end
qHill = get_hillNumbers(pop,qV); % Hill numbers of population at equilibrium

% take random sample from population
sampleV = randsample(pop,nSample,'false');
qHillSample = get_hillNumbers(sampleV,qV); % Hill numbers of sample at equilibrium


