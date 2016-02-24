function [Tp]=potentialtemperature(T,P) % Input pressure in GPa
dpdz = 3300 * 9.8 / 10^9; % Pressure gradient (GPa / m)
% Potential temperature formula from eqn 5 of McKenzie and Bickle 1988
% Using thermal expansion coeff. of 3*10^-5 / Kelvin
Tp = T * exp(-9.8 * 3*10^-5 * P/dpdz /1000);