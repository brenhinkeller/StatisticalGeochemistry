function ratio=nanratio(num,denom)
% ratio=NANRATIO(num,denom)
% Return the fractional mean ratio of num/denom: calculate average ratio 
% as a fraction num/(num+denom) to avoid numerical instibility for small
% values of denom.

ratio = fracttoratio(nanmean(num./(num+denom)));