function hillNumb = get_hillNumbers(pp,qV)
% calculate Hill numbers of order specified in qV

n = numel(pp);
uniqueV = unique(pp); % unique variants in population 
if numel(uniqueV)>1
    [p,uniqueV] = hist(pp,uniqueV); % frequencies of unique variants 
else
    p = n;
end

p = p./n; % relative frequencies
for i = 1:numel(qV)
    q = qV(i);
    if q ~= 1 % 
        hillNumb(i) = sum(p.^q)^(1/(1-q)); % calculation of Hill number of order i -> not defined for order 1 
    else
        hillNumb(i) = exp(-sum(p.*log(p)));
    end
end
