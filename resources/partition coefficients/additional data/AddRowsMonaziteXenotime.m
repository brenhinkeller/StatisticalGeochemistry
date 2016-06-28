% Add Monazite and Xenotime
pdata.Monazite=pdata.(pdata.minerals{1}); % Copy based on existing field
for e=pdata.Monazite.elements'
    pdata.Monazite.(e{1})=NaN(size( pdata.Monazite.(e{1}) )); % NaN out any existing data
end
pdata.Xenotime=pdata.Monazite; % Copy empty struct for xenotime too
pdata.minerals=unique(sort([pdata.minerals; {'Monazite';'Xenotime'}])); % Add new fields to pdata.minerals
pdata=orderfields(pdata,[{'minerals'}; pdata.minerals; {'samples';'SiO2';'SiO2_Err'}]); % Reorder struct

%% Add a row
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Wark and Miller, 1993'; 
pdata.samples{end,2}='SW1 Granite';
pdata.SiO2(end)=70.4;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=14.8;

pdata.Monazite.La(end)=2242.5468049844;
pdata.Monazite.Ce(end)=2227.5286531761;
pdata.Monazite.Nd(end)=1899.3887367045;
pdata.Monazite.Sm(end)=1936.5936280878;
pdata.Monazite.Gd(end)=1016.6771206416;
pdata.Monazite.Ho(end)=303.2340140609;
pdata.Monazite.Yb(end)=NaN;
pdata.Monazite.Y(end)=217.4812174898;
pdata.Monazite.Th(end)=2334.0059883975;
pdata.Monazite.U(end)=2997.9700579043;
pdata.Monazite.La_Err(end)=200.6130450651;
pdata.Monazite.Ce_Err(end)=83.4199629352;
pdata.Monazite.Nd_Err(end)=12.3671331108;
pdata.Monazite.Sm_Err(end)=177.2136865301;
pdata.Monazite.Gd_Err(end)=278.0719090249;
pdata.Monazite.Ho_Err(end)=47.648628362;
pdata.Monazite.Yb_Err(end)=NaN;
pdata.Monazite.Y_Err(end)=114.442748776;
pdata.Monazite.Th_Err(end)=413.0547844408;
pdata.Monazite.U_Err(end)=2301.5893826873;


for m=pdata.minerals'
    for e=pdata.(m{1}).elements(1:length(pdata.Sphene.elements)/2)'
        % Convert standard errors to log scale
        pdata.(m{1}).([e{1} '_Err'])(end)=log10(pdata.(m{1}).(e{1})(end)+pdata.(m{1}).([e{1} '_Err'])(end)) - log10(pdata.(m{1}).(e{1})(end));
        % Convert values to log scale
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end



%% Add a row
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Wark and Miller, 1993'; 
pdata.samples{end,2}='SW3 Granite';
pdata.SiO2(end)=73.7;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=14.5;

pdata.Xenotime.La(end)=12.6322873116;
pdata.Xenotime.Ce(end)=30.0395850119;
pdata.Xenotime.Nd(end)=185.0873273844;
pdata.Xenotime.Sm(end)=2028.0977314688;
pdata.Xenotime.Gd(end)=4999.77855323;
pdata.Xenotime.Ho(end)=12599.9977236599;
pdata.Xenotime.Yb(end)=NaN;
pdata.Xenotime.Y(end)=7475.2875146506;
pdata.Xenotime.Th(end)=193.3373731253;
pdata.Xenotime.U(end)=15135.7647790506;
pdata.Xenotime.La_Err(end)=8.9323760199;
pdata.Xenotime.Ce_Err(end)=17.8873214871;
pdata.Xenotime.Nd_Err(end)=6.7116156054;
pdata.Xenotime.Sm_Err(end)=93.2736038264;
pdata.Xenotime.Gd_Err(end)=290.2949118585;
pdata.Xenotime.Ho_Err(end)=134.9930883839;
pdata.Xenotime.Yb_Err(end)=NaN;
pdata.Xenotime.Y_Err(end)=167.4964005878;
pdata.Xenotime.Th_Err(end)=107.7110411344;
pdata.Xenotime.U_Err(end)=6902.6553059114;


for m=pdata.minerals'
    for e=pdata.(m{1}).elements(1:length(pdata.Sphene.elements)/2)'
        % Convert standard errors to log scale
        pdata.(m{1}).([e{1} '_Err'])(end)=log10(pdata.(m{1}).(e{1})(end)+pdata.(m{1}).([e{1} '_Err'])(end)) - log10(pdata.(m{1}).(e{1})(end));
        % Convert values to log scale
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end

%% Add a row
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Wark and Miller, 1993'; 
pdata.samples{end,2}='SW5 Aplite';
pdata.SiO2(end)=73.6;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=14.3;

pdata.Monazite.La(end)=13740.8794221758;
pdata.Monazite.Ce(end)=16029.2806654074;
pdata.Monazite.Nd(end)=9345.4966711036;
pdata.Monazite.Sm(end)=11191.5762519736;
pdata.Monazite.Gd(end)=6579.858694506;
pdata.Monazite.Ho(end)=1282.0985210475;
pdata.Monazite.Yb(end)=8500.0827055232;
pdata.Monazite.Y(end)=704.9883792908;
pdata.Monazite.Th(end)=16525.0036387832;
pdata.Monazite.U(end)=27266.9032827439;
pdata.Monazite.La_Err(end)=1549.4666237088;
pdata.Monazite.Ce_Err(end)=1194.8992562618;
pdata.Monazite.Nd_Err(end)=442.3713041344;
pdata.Monazite.Sm_Err(end)=2098.9509414749;
pdata.Monazite.Gd_Err(end)=1849.7167434591;
pdata.Monazite.Ho_Err(end)=341.6399659636;
pdata.Monazite.Yb_Err(end)=276.6289211527;
pdata.Monazite.Y_Err(end)=32.8545576433;
pdata.Monazite.Th_Err(end)=1641.6107984943;
pdata.Monazite.U_Err(end)=6954.4353477787;

pdata.Xenotime.La(end)=22.052053281;
pdata.Xenotime.Ce(end)=88.932981943;
pdata.Xenotime.Nd(end)=498.4682894014;
pdata.Xenotime.Sm(end)=3265.530747743;
pdata.Xenotime.Gd(end)=6416.5867666026;
pdata.Xenotime.Ho(end)=11144.3948367978;
pdata.Xenotime.Yb(end)=13010.3306717192;
pdata.Xenotime.Y(end)=11293.6761997064;
pdata.Xenotime.Th(end)=1387.1353419417;
pdata.Xenotime.U(end)=48604.7201373818;
pdata.Xenotime.La_Err(end)=10.3954376094;
pdata.Xenotime.Ce_Err(end)=5.0308091682;
pdata.Xenotime.Nd_Err(end)=26.6015326522;
pdata.Xenotime.Sm_Err(end)=224.1824209614;
pdata.Xenotime.Gd_Err(end)=484.8928870711;
pdata.Xenotime.Ho_Err(end)=278.9478641175;
pdata.Xenotime.Yb_Err(end)=1011.9662347797;
pdata.Xenotime.Y_Err(end)=96.6197820004;
pdata.Xenotime.Th_Err(end)=36.553520747;
pdata.Xenotime.U_Err(end)=6288.7458293325;




for m=pdata.minerals'
    for e=pdata.(m{1}).elements(1:length(pdata.Sphene.elements)/2)'
        % Convert standard errors to log scale
        pdata.(m{1}).([e{1} '_Err'])(end)=log10(pdata.(m{1}).(e{1})(end)+pdata.(m{1}).([e{1} '_Err'])(end)) - log10(pdata.(m{1}).(e{1})(end));
        % Convert values to log scale
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end