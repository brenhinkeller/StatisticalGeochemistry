%% Add a row
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Hermann, 2002'; 
pdata.samples{end,2}='C-1245'; % 2 GPa, 900 C
pdata.SiO2(end)=62.47;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=13.10;

pdata.Allanite.P(end)=5.2591463415;
pdata.Allanite.Y(end)=157.1229698376;
pdata.Allanite.Zr(end)=2.85;
pdata.Allanite.Ba(end)=0.1946472019;
pdata.Allanite.La(end)=211.868852459;
pdata.Allanite.Ce(end)=215.242881072;
pdata.Allanite.Pr(end)=211.1054421769;
pdata.Allanite.Nd(end)=204.757118928;
pdata.Allanite.Sm(end)=192.2372881356;
pdata.Allanite.Eu(end)=271.6894977169;
pdata.Allanite.Gd(end)=201.5062761506;
pdata.Allanite.Dy(end)=199.0355329949;
pdata.Allanite.Er(end)=153.91184573;
pdata.Allanite.Yb(end)=101.2082262211;
pdata.Allanite.Lu(end)=85.6544502618;
pdata.Allanite.Hf(end)=2.5833333333;
pdata.Allanite.Th(end)=61.1272727273;
pdata.Allanite.U(end)=20.3846153846;

pdata.Allanite.Sc_Err(end)=1.8633887437;
pdata.Allanite.Rb_Err(end)=14.9627574572;
pdata.Allanite.Sr_Err(end)=0.07125;
pdata.Allanite.Y_Err(end)=0.0439209136;
pdata.Allanite.Ba_Err(end)=18.0625365316;
pdata.Allanite.La_Err(end)=18.4831291791;
pdata.Allanite.Ce_Err(end)=18.570237363;
pdata.Allanite.Pr_Err(end)=19.1462359554;
pdata.Allanite.Nd_Err(end)=17.6356013477;
pdata.Allanite.Sm_Err(end)=40.0996667381;
pdata.Allanite.Eu_Err(end)=18.7497177868;
pdata.Allanite.Gd_Err(end)=16.4040554896;
pdata.Allanite.Tb_Err(end)=17.0698870572;
pdata.Allanite.Dy_Err(end)=9.8665869491;
pdata.Allanite.Ho_Err(end)=6.370759426;
pdata.Allanite.Er_Err(end)=0.1506944444;
pdata.Allanite.Tm_Err(end)=8.5638336748;
pdata.Allanite.Yb_Err(end)=0.7305943568;


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


pdata.samples{end,1}='Brooks et al., 1981';
pdata.samples{end,2}='Sandy Braes Obsidian';
pdata.SiO2(end)=74;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=12;


pdata.Allanite.La(end)=820;
pdata.Allanite.Ce(end)=635;
pdata.Allanite.Nd(end)=463;
pdata.Allanite.Sm(end)=205;
pdata.Allanite.Eu(end)=81;
pdata.Allanite.Gd(end)=130;
pdata.Allanite.Tb(end)=71;
pdata.Allanite.Yb(end)=8.9;
pdata.Allanite.Lu(end)=7.7;
pdata.Allanite.U(end)=3.35;
pdata.Allanite.Th(end)=168;


for m=pdata.minerals'
    for e=pdata.(m{1}).elements(1:length(pdata.Sphene.elements)/2)'
        % Convert values to log scale
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end
