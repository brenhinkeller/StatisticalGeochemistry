function FM = meltFM(CaO, Na2O, K2O, Al2O3, SiO2, TiO2, FeOT, MgO, MnO, P2O5)

%Cation ratio
Na=Na2O/30.9895;
K=K2O/47.0827;
Ca=CaO/56.0774;
Al=Al2O3/50.9806;
Si=SiO2/60.0843;
Ti=TiO2/55.8667;
Fe=FeOT/71.8444;
Mg=MgO/24.3050;
Mn=MnO/70.9374;
P=P2O5/70.9723;

Ti(isnan(Ti))=0;
Mn(isnan(Mn))=0;
P(isnan(P))=0;

% Normalize cation ratios
normconst=Na+K+Ca+Al+Si+Ti+Fe+Mg+Mn+P;
Na=Na./normconst;
K=K./normconst;
Ca=Ca./normconst;
Mg=Mg./normconst;
Fe=Fe./normconst;
Al=Al./normconst;
Si=Si./normconst;

FM=(Na + K + 2*(Ca+Mg+Fe))./(Al .* Si); % Cation ratio
