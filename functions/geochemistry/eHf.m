function [eHf, Hf176_Hf177_t]=eHf(Hf176_Hf177, Lu176_Hf177, t)
% Calculates the initial Hf ratio and epsilon Hf at time t Ma

lambda = 1.867*10^-11; % Lutetium decay constant (Soderlund et al., 2004)

CHUR_Hf176_Hf177 = 0.282785; % Present-day CHUR Hf ratio (Bouvier et al., 2008)
CHUR_Lu176_Hf177 = 0.0336; %Present-day CHUR Lu/Hf (Bouvier et al., 2008)

% Calculate initial Hf ratio at time t
Hf176_Hf177_t = Hf176_Hf177 - Lu176_Hf177.*(exp(t *10^6*lambda) - 1);

% Calculate CHUR Hf ratio at time t
CHUR_Hf176_Hf177_t = CHUR_Hf176_Hf177 - CHUR_Lu176_Hf177.*(exp(t*10^6*lambda) - 1);

% Calculate corresponding epsilon Hf
eHf=(Hf176_Hf177_t ./ CHUR_Hf176_Hf177_t - 1) .* 10^4;