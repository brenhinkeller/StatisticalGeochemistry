function x=roundsigfigs(x, sfigs)
% Rounds x to sfigs significant figures.
d=sfigs-floor(log10(x))-1;
x=round(x.*10.^d).*10.^-d;