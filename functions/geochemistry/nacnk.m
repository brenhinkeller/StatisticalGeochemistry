function out=nacnk(CaO,Na2O,K2O)
% Calculates the molar Na/CNK value for a sample with given, CaO, Na2O and K2O
% contents.

out=Na2O./30.9895./(CaO./56.0774+Na2O./30.9895+K2O./47.0980);
end