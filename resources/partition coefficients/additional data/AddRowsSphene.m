% Try looking at Al+Si/(Na+K) as a measure of network
% strength/frameworkiness
%% Add a row
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];

pdata.samples{end,1}='Tiepolo et al, 2002';
pdata.samples{end,2}='rb21-1';
pdata.SiO2(end)=55.54;
pdata.SiO2_Err(end)=5;


pdata.Sphene.Li(end)=0.01;
pdata.Sphene.Be(end)=0.001;
pdata.Sphene.B(end)=0.0003;
pdata.Sphene.Sc(end)=2.41;
pdata.Sphene.V(end)=5.43;
pdata.Sphene.Rb(end)=0.0025;
pdata.Sphene.Sr(end)=2.77;
pdata.Sphene.Y(end)=8.36;
pdata.Sphene.Zr(end)=3.18;
pdata.Sphene.Nb(end)=2.19;
pdata.Sphene.Ba(end)=0.0015;
pdata.Sphene.La(end)=6.43;
pdata.Sphene.Ce(end)=11.1;
pdata.Sphene.Nd(end)=18.6;
pdata.Sphene.Sm(end)=21.4;
pdata.Sphene.Eu(end)=20.4;
pdata.Sphene.Gd(end)=18.3;
pdata.Sphene.Dy(end)=12.3;
pdata.Sphene.Er(end)=8.32;
pdata.Sphene.Yb(end)=4.51;
pdata.Sphene.Hf(end)=3.81;
pdata.Sphene.Ta(end)=7.54;
pdata.Sphene.Pb(end)=0.05;
pdata.Sphene.Th(end)=0.22;
pdata.Sphene.U(end)=0.18;


pdata.Sphene.Li_Err(end)=0.005;
pdata.Sphene.Be_Err(end)=0.0005;
pdata.Sphene.B_Err(end)=0.00015;
pdata.Sphene.Sc_Err(end)=0.83;
pdata.Sphene.V_Err(end)=0.40;
pdata.Sphene.Rb_Err(end)=0.0025;
pdata.Sphene.Sr_Err(end)=0.35;
pdata.Sphene.Y_Err(end)=0.55;
pdata.Sphene.Zr_Err(end)=0.19;
pdata.Sphene.Nb_Err(end)=0.35;
pdata.Sphene.Ba_Err(end)=0.0015;
pdata.Sphene.La_Err(end)=0.6;
pdata.Sphene.Ce_Err(end)=1.04;
pdata.Sphene.Nd_Err(end)=1.70;
pdata.Sphene.Sm_Err(end)=2.19;
pdata.Sphene.Eu_Err(end)=2.1;
pdata.Sphene.Gd_Err(end)=1.4;
pdata.Sphene.Dy_Err(end)=1.06;
pdata.Sphene.Er_Err(end)=0.7;
pdata.Sphene.Yb_Err(end)=0.39;
pdata.Sphene.Hf_Err(end)=0.26;
pdata.Sphene.Ta_Err(end)=0.7;
pdata.Sphene.Pb_Err(end)=0.01;
pdata.Sphene.Th_Err(end)=0.05;
pdata.Sphene.U_Err(end)=0.05;


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

pdata.samples{end,1}='Tiepolo et al, 2002';
pdata.samples{end,2}='rb31-3';
pdata.SiO2(end)=55.32;
pdata.SiO2_Err(end)=5;


pdata.Sphene.Li(end)=0.01;
pdata.Sphene.Be(end)=0.001;
pdata.Sphene.B(end)=0.001;
pdata.Sphene.Sc(end)=1.64;
pdata.Sphene.V(end)=5.94;
pdata.Sphene.Sr(end)=2.68;
pdata.Sphene.Y(end)=5.42;
pdata.Sphene.Zr(end)=1.92;
pdata.Sphene.Nb(end)=2.20;
pdata.Sphene.La(end)=4.73;
pdata.Sphene.Ce(end)=7.57;
pdata.Sphene.Nd(end)=12.4;
pdata.Sphene.Sm(end)=14.0;
pdata.Sphene.Eu(end)=13.8;
pdata.Sphene.Gd(end)=11.9;
pdata.Sphene.Dy(end)=8.27;
pdata.Sphene.Er(end)=5.54;
pdata.Sphene.Yb(end)=3.02;
pdata.Sphene.Hf(end)=2.43;
pdata.Sphene.Ta(end)=6.55;
pdata.Sphene.Pb(end)=0.04;
pdata.Sphene.Th(end)=0.16;
pdata.Sphene.U(end)=0.14;


pdata.Sphene.Li_Err(end)=0.005;
pdata.Sphene.Be_Err(end)=0.0005;
pdata.Sphene.B_Err(end)=0.005;
pdata.Sphene.Sc_Err(end)=0.36;
pdata.Sphene.V_Err(end)=1.03;
pdata.Sphene.Sr_Err(end)=0.46;
pdata.Sphene.Y_Err(end)=1.07;
pdata.Sphene.Zr_Err(end)=0.96;
pdata.Sphene.Nb_Err(end)=1.16;
pdata.Sphene.La_Err(end)=2.19;
pdata.Sphene.Ce_Err(end)=2.88;
pdata.Sphene.Nd_Err(end)=3.86;
pdata.Sphene.Sm_Err(end)=3.92;
pdata.Sphene.Eu_Err(end)=4.02;
pdata.Sphene.Gd_Err(end)=2.73;
pdata.Sphene.Dy_Err(end)=2;
pdata.Sphene.Er_Err(end)=1.23;
pdata.Sphene.Yb_Err(end)=0.57;
pdata.Sphene.Hf_Err(end)=0.77;
pdata.Sphene.Ta_Err(end)=2.06;
pdata.Sphene.Pb_Err(end)=0.01;
pdata.Sphene.Th_Err(end)=0.09;
pdata.Sphene.U_Err(end)=0.08;


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

pdata.samples{end,1}='Tiepolo et al, 2002';
pdata.samples{end,2}='rb33-3';
pdata.SiO2(end)=55.8;
pdata.SiO2_Err(end)=5;


pdata.Sphene.Sc(end)=1;
pdata.Sphene.V(end)=2.72;
pdata.Sphene.Rb(end)=0.01;
pdata.Sphene.Sr(end)=5.88;
pdata.Sphene.Y(end)=8.04;
pdata.Sphene.Zr(end)=1.71;
pdata.Sphene.Nb(end)=4.82;
pdata.Sphene.Ba(end)=0.01;
pdata.Sphene.La(end)=7.50;
pdata.Sphene.Ce(end)=12.1;
pdata.Sphene.Nd(end)=23.6;
pdata.Sphene.Sm(end)=26.4;
pdata.Sphene.Eu(end)=25.9;
pdata.Sphene.Gd(end)=20.2;
pdata.Sphene.Dy(end)=11.3;
pdata.Sphene.Er(end)=5.34;
pdata.Sphene.Yb(end)=3.31;
pdata.Sphene.Hf(end)=1.58;
pdata.Sphene.Ta(end)=8.82;
pdata.Sphene.Pb(end)=0.07;
pdata.Sphene.Th(end)=0.27;
pdata.Sphene.U(end)=0.21;


pdata.Sphene.Sc_Err(end)=0.29;
pdata.Sphene.V_Err(end)=0.76;
pdata.Sphene.Rb_Err(end)=0.01;
pdata.Sphene.Sr_Err(end)=0.04;
pdata.Sphene.Y_Err(end)=0.71;
pdata.Sphene.Zr_Err(end)=0.37;
pdata.Sphene.Nb_Err(end)=1.03;
pdata.Sphene.Ba_Err(end)=0.01;
pdata.Sphene.La_Err(end)=1.41;
pdata.Sphene.Ce_Err(end)=1.95;
pdata.Sphene.Nd_Err(end)=2.64;
pdata.Sphene.Sm_Err(end)=1.19;
pdata.Sphene.Eu_Err(end)=2.13;
pdata.Sphene.Gd_Err(end)=1.75;
pdata.Sphene.Dy_Err(end)=0.31;
pdata.Sphene.Er_Err(end)=0.55;
pdata.Sphene.Yb_Err(end)=0.13;
pdata.Sphene.Hf_Err(end)=0.12;
pdata.Sphene.Ta_Err(end)=1.87;
pdata.Sphene.Pb_Err(end)=0.02;
pdata.Sphene.Th_Err(end)=0.08;
pdata.Sphene.U_Err(end)=0.04;


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

pdata.samples{end,1}='Tiepolo et al, 2002';
pdata.samples{end,2}='rb34-3';
pdata.SiO2(end)=55.15;
pdata.SiO2_Err(end)=5;


pdata.Sphene.Li(end)=0.009;
pdata.Sphene.Be(end)=0.003;
pdata.Sphene.B(end)=0.011;
pdata.Sphene.Sc(end)=1.13;
pdata.Sphene.V(end)=21.0;
pdata.Sphene.Rb(end)=0.005;
pdata.Sphene.Sr(end)=1.50;
pdata.Sphene.Y(end)=4.52;
pdata.Sphene.Zr(end)=1.29;
pdata.Sphene.Nb(end)=1.84;
pdata.Sphene.Ba(end)=0.005;
pdata.Sphene.La(end)=2.39;
pdata.Sphene.Ce(end)=4.01;
pdata.Sphene.Nd(end)=7.48;
pdata.Sphene.Sm(end)=8.89;
pdata.Sphene.Eu(end)=6.85;
pdata.Sphene.Gd(end)=7.82;
pdata.Sphene.Dy(end)=5.33;
pdata.Sphene.Er(end)=3.66;
pdata.Sphene.Yb(end)=2.22;
pdata.Sphene.Hf(end)=1.55;
pdata.Sphene.Ta(end)=4.44;
pdata.Sphene.Pb(end)=0.05;
pdata.Sphene.Th(end)=0.25;
pdata.Sphene.U(end)=0.21;


pdata.Sphene.Li_Err(end)=0.0045;
pdata.Sphene.Be_Err(end)=0.0015;
pdata.Sphene.B_Err(end)=0.0055;
pdata.Sphene.Sc_Err(end)=0.56;
pdata.Sphene.V_Err(end)=7.3;
pdata.Sphene.Rb_Err(end)=0.005;
pdata.Sphene.Sr_Err(end)=0.43;
pdata.Sphene.Y_Err(end)=0.51;
pdata.Sphene.Zr_Err(end)=0.68;
pdata.Sphene.Nb_Err(end)=0.39;
pdata.Sphene.Ba_Err(end)=0.005;
pdata.Sphene.La_Err(end)=0.48;
pdata.Sphene.Ce_Err(end)=0.81;
pdata.Sphene.Nd_Err(end)=1.82;
pdata.Sphene.Sm_Err(end)=1.95;
pdata.Sphene.Eu_Err(end)=1.17;
pdata.Sphene.Gd_Err(end)=1.06;
pdata.Sphene.Dy_Err(end)=0.49;
pdata.Sphene.Er_Err(end)=0.51;
pdata.Sphene.Yb_Err(end)=0.33;
pdata.Sphene.Hf_Err(end)=0.5;
pdata.Sphene.Ta_Err(end)=0.41;
pdata.Sphene.Pb_Err(end)=0.02;
pdata.Sphene.Th_Err(end)=0.06;
pdata.Sphene.U_Err(end)=0.04;


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

pdata.samples{end,1}='Ackerson 2011';
pdata.samples{end,2}='Ammonia Tanks Rhyolite';
pdata.SiO2(end)=75.5;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=12.3;


pdata.Sphene.Sc(end)=25.3;
pdata.Sphene.Rb(end)=0.236;
pdata.Sphene.Sr(end)=1.31;
pdata.Sphene.Y(end)=1920;
pdata.Sphene.Ba(end)=11;
pdata.Sphene.La(end)=370;
pdata.Sphene.Ce(end)=570;
pdata.Sphene.Pr(end)=1000;
pdata.Sphene.Nd(end)=1300;
pdata.Sphene.Sm(end)=1700;
pdata.Sphene.Eu(end)=1600;
pdata.Sphene.Gd(end)=1500;
pdata.Sphene.Tb(end)=3200;
pdata.Sphene.Dy(end)=1400;
pdata.Sphene.Ho(end)=1200;
pdata.Sphene.Er(end)=940;
pdata.Sphene.Tm(end)=700;
pdata.Sphene.Yb(end)=520;
pdata.Sphene.Lu(end)=370;
pdata.Sphene.Pb(end)=1.35;
pdata.Sphene.Th(end)=27;
pdata.Sphene.U(end)=9;

pdata.Sphene.Sc_Err(end)=4.1;
pdata.Sphene.Rb_Err(end)=0.035;
pdata.Sphene.Sr_Err(end)=0.62;
pdata.Sphene.Y_Err(end)=640;
pdata.Sphene.Ba_Err(end)=16;
pdata.Sphene.La_Err(end)=460;
pdata.Sphene.Ce_Err(end)=480;
pdata.Sphene.Pr_Err(end)=1200;
pdata.Sphene.Nd_Err(end)=1500;
pdata.Sphene.Sm_Err(end)=1900;
pdata.Sphene.Eu_Err(end)=1500;
pdata.Sphene.Gd_Err(end)=1600;
pdata.Sphene.Tb_Err(end)=3200;
pdata.Sphene.Dy_Err(end)=1400;
pdata.Sphene.Ho_Err(end)=1200;
pdata.Sphene.Er_Err(end)=950;
pdata.Sphene.Tm_Err(end)=700;
pdata.Sphene.Yb_Err(end)=520;
pdata.Sphene.Lu_Err(end)=370;
pdata.Sphene.Pb_Err(end)=0.73;
pdata.Sphene.Th_Err(end)=12;
pdata.Sphene.U_Err(end)=6.7;



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

pdata.samples{end,1}='Ackerson 2011';
pdata.samples{end,2}='Tiva Canyon Rhyolite';
pdata.SiO2(end)=72.21;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=13.16;


pdata.Sphene.Sc(end)=14.2;
pdata.Sphene.Rb(end)=0.16;
pdata.Sphene.Sr(end)=0.43;
pdata.Sphene.Y(end)=800;
pdata.Sphene.Ba(end)=0.35;
pdata.Sphene.La(end)=150;
pdata.Sphene.Ce(end)=240;
pdata.Sphene.Pr(end)=410;
pdata.Sphene.Nd(end)=540;
pdata.Sphene.Sm(end)=800;
pdata.Sphene.Eu(end)=580;
pdata.Sphene.Gd(end)=710;
pdata.Sphene.Tb(end)=830;
pdata.Sphene.Dy(end)=1000;
pdata.Sphene.Ho(end)=900;
pdata.Sphene.Er(end)=730;
pdata.Sphene.Tm(end)=640;
pdata.Sphene.Yb(end)=490;
pdata.Sphene.Lu(end)=350;
pdata.Sphene.Pb(end)=0.42;
pdata.Sphene.Th(end)=22;
pdata.Sphene.U(end)=6.9;

pdata.Sphene.Sc_Err(end)=9.5;
pdata.Sphene.Rb_Err(end)=0.11;
pdata.Sphene.Sr_Err(end)=0.49;
pdata.Sphene.Y_Err(end)=660;
pdata.Sphene.Ba_Err(end)=0.29;
pdata.Sphene.La_Err(end)=150;
pdata.Sphene.Ce_Err(end)=170;
pdata.Sphene.Pr_Err(end)=360;
pdata.Sphene.Nd_Err(end)=420;
pdata.Sphene.Sm_Err(end)=570;
pdata.Sphene.Eu_Err(end)=550;
pdata.Sphene.Gd_Err(end)=540;
pdata.Sphene.Tb_Err(end)=630;
pdata.Sphene.Dy_Err(end)=620;
pdata.Sphene.Ho_Err(end)=630;
pdata.Sphene.Er_Err(end)=470;
pdata.Sphene.Tm_Err(end)=510;
pdata.Sphene.Yb_Err(end)=350;
pdata.Sphene.Lu_Err(end)=580;
pdata.Sphene.Pb_Err(end)=0.46;
pdata.Sphene.Th_Err(end)=16;
pdata.Sphene.U_Err(end)=6.5;


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

pdata.samples{end,1}='Ackerson 2011';
pdata.samples{end,2}='Pagosa Peak Dacite';
pdata.SiO2(end)=74.87;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=12.45;


pdata.Sphene.Sc(end)=18;
pdata.Sphene.Rb(end)=0.039;
pdata.Sphene.Sr(end)=0.5;
pdata.Sphene.Y(end)=870;
pdata.Sphene.Ba(end)=0.18;
pdata.Sphene.La(end)=200;
pdata.Sphene.Ce(end)=370;
pdata.Sphene.Pr(end)=690;
pdata.Sphene.Nd(end)=920;
pdata.Sphene.Sm(end)=1230;
pdata.Sphene.Eu(end)=610;
pdata.Sphene.Gd(end)=810;
pdata.Sphene.Tb(end)=1130;
pdata.Sphene.Dy(end)=1100;
pdata.Sphene.Ho(end)=1000;
pdata.Sphene.Er(end)=810;
pdata.Sphene.Tm(end)=670;
pdata.Sphene.Yb(end)=510;
pdata.Sphene.Lu(end)=340;
pdata.Sphene.Pb(end)=0.19;
pdata.Sphene.Th(end)=25;
pdata.Sphene.U(end)=9;

pdata.Sphene.Sc_Err(end)=14;
pdata.Sphene.Rb_Err(end)=0.026;
pdata.Sphene.Sr_Err(end)=0.3;
pdata.Sphene.Y_Err(end)=730;
pdata.Sphene.Ba_Err(end)=0.16;
pdata.Sphene.La_Err(end)=210;
pdata.Sphene.Ce_Err(end)=270;
pdata.Sphene.Pr_Err(end)=550;
pdata.Sphene.Nd_Err(end)=750;
pdata.Sphene.Sm_Err(end)=940;
pdata.Sphene.Eu_Err(end)=580;
pdata.Sphene.Gd_Err(end)=710;
pdata.Sphene.Tb_Err(end)=830;
pdata.Sphene.Dy_Err(end)=760;
pdata.Sphene.Ho_Err(end)=760;
pdata.Sphene.Er_Err(end)=590;
pdata.Sphene.Tm_Err(end)=560;
pdata.Sphene.Yb_Err(end)=380;
pdata.Sphene.Lu_Err(end)=320;
pdata.Sphene.Pb_Err(end)=0.15;
pdata.Sphene.Th_Err(end)=19;
pdata.Sphene.U_Err(end)=8.7;


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

pdata.samples{end,1}='Ackerson 2011';
pdata.samples{end,2}='Fish Canyon Rhyolite';
pdata.SiO2(end)=75.05;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=12.99;


pdata.Sphene.Sc(end)=5.5;
pdata.Sphene.Rb(end)=0.056;
pdata.Sphene.Sr(end)=0.154;
pdata.Sphene.Y(end)=780;
pdata.Sphene.Ba(end)=0.072;
pdata.Sphene.La(end)=320;
pdata.Sphene.Ce(end)=580;
pdata.Sphene.Pr(end)=720;
pdata.Sphene.Nd(end)=850;
pdata.Sphene.Sm(end)=910;
pdata.Sphene.Eu(end)=360;
pdata.Sphene.Gd(end)=790;
pdata.Sphene.Tb(end)=880;
pdata.Sphene.Dy(end)=900;
pdata.Sphene.Ho(end)=820;
pdata.Sphene.Er(end)=730;
pdata.Sphene.Tm(end)=650;
pdata.Sphene.Yb(end)=550;
pdata.Sphene.Lu(end)=430;
pdata.Sphene.Pb(end)=0.24;
pdata.Sphene.Th(end)=44;
pdata.Sphene.U(end)=30;

pdata.Sphene.Sc_Err(end)=3.8;
pdata.Sphene.Rb_Err(end)=0.038;
pdata.Sphene.Sr_Err(end)=0.087;
pdata.Sphene.Y_Err(end)=650;
pdata.Sphene.Ba_Err(end)=0.047;
pdata.Sphene.La_Err(end)=360;
pdata.Sphene.Ce_Err(end)=390;
pdata.Sphene.Pr_Err(end)=610;
pdata.Sphene.Nd_Err(end)=670;
pdata.Sphene.Sm_Err(end)=670;
pdata.Sphene.Eu_Err(end)=330;
pdata.Sphene.Gd_Err(end)=610;
pdata.Sphene.Tb_Err(end)=640;
pdata.Sphene.Dy_Err(end)=570;
pdata.Sphene.Ho_Err(end)=600;
pdata.Sphene.Er_Err(end)=520;
pdata.Sphene.Tm_Err(end)=530;
pdata.Sphene.Yb_Err(end)=390;
pdata.Sphene.Lu_Err(end)=370;
pdata.Sphene.Pb_Err(end)=0.18;
pdata.Sphene.Th_Err(end)=33;
pdata.Sphene.U_Err(end)=28;


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


pdata.samples{end,1}='Ackerson 2011';
pdata.samples{end,2}='Bonanza Rhyolite';
pdata.SiO2(end)=76.02;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=12.02;


pdata.Sphene.Sc(end)=17;
pdata.Sphene.Rb(end)=0.032;
pdata.Sphene.Sr(end)=0.28;
pdata.Sphene.Y(end)=900;
pdata.Sphene.Ba(end)=1.09;
pdata.Sphene.La(end)=240;
pdata.Sphene.Ce(end)=470;
pdata.Sphene.Pr(end)=620;
pdata.Sphene.Nd(end)=800;
pdata.Sphene.Sm(end)=1010;
pdata.Sphene.Eu(end)=420;
pdata.Sphene.Gd(end)=840;
pdata.Sphene.Tb(end)=2000;
pdata.Sphene.Dy(end)=1000;
pdata.Sphene.Ho(end)=860;
pdata.Sphene.Er(end)=690;
pdata.Sphene.Tm(end)=540;
pdata.Sphene.Yb(end)=400;
pdata.Sphene.Lu(end)=290;
pdata.Sphene.Pb(end)=0.93;
pdata.Sphene.Th(end)=26;
pdata.Sphene.U(end)=27;

pdata.Sphene.Sc_Err(end)=18;
pdata.Sphene.Rb_Err(end)=0.051;
pdata.Sphene.Sr_Err(end)=0.28;
pdata.Sphene.Y_Err(end)=1200;
pdata.Sphene.Ba_Err(end)=0.89;
pdata.Sphene.La_Err(end)=290;
pdata.Sphene.Ce_Err(end)=430;
pdata.Sphene.Pr_Err(end)=530;
pdata.Sphene.Nd_Err(end)=610;
pdata.Sphene.Sm_Err(end)=640;
pdata.Sphene.Eu_Err(end)=330;
pdata.Sphene.Gd_Err(end)=590;
pdata.Sphene.Tb_Err(end)=1200;
pdata.Sphene.Dy_Err(end)=560;
pdata.Sphene.Ho_Err(end)=540;
pdata.Sphene.Er_Err(end)=430;
pdata.Sphene.Tm_Err(end)=360;
pdata.Sphene.Yb_Err(end)=260;
pdata.Sphene.Lu_Err(end)=220;
pdata.Sphene.Pb_Err(end)=0.83;
pdata.Sphene.Th_Err(end)=25;
pdata.Sphene.U_Err(end)=33;


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

pdata.samples{end,1}='Ackerson 2011';
pdata.samples{end,2}='Peach Springs Rhyolite';
pdata.SiO2(end)=72.40;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=18.36;


pdata.Sphene.Sc(end)=31;
pdata.Sphene.Rb(end)=1.13;
pdata.Sphene.Sr(end)=0.2;
pdata.Sphene.Y(end)=10200;
pdata.Sphene.Ba(end)=4.4;
pdata.Sphene.La(end)=1070;
pdata.Sphene.Ce(end)=2000;
pdata.Sphene.Pr(end)=2800;
pdata.Sphene.Nd(end)=3900;
pdata.Sphene.Sm(end)=5600;
pdata.Sphene.Eu(end)=6300;
pdata.Sphene.Gd(end)=4700;
pdata.Sphene.Tb(end)=12000;
pdata.Sphene.Dy(end)=6800;
pdata.Sphene.Ho(end)=6700;
pdata.Sphene.Er(end)=4600;
pdata.Sphene.Tm(end)=2800;
pdata.Sphene.Yb(end)=1320;
pdata.Sphene.Lu(end)=790;
pdata.Sphene.Pb(end)=0.78;
pdata.Sphene.Th(end)=70;
pdata.Sphene.U(end)=33;

pdata.Sphene.Sc_Err(end)=30;
pdata.Sphene.Rb_Err(end)=0.69;
pdata.Sphene.Sr_Err(end)=0.18;
pdata.Sphene.Y_Err(end)=9800;
pdata.Sphene.Ba_Err(end)=2.9;
pdata.Sphene.La_Err(end)=950;
pdata.Sphene.Ce_Err(end)=1000;
pdata.Sphene.Pr_Err(end)=1800;
pdata.Sphene.Nd_Err(end)=2400;
pdata.Sphene.Sm_Err(end)=3400;
pdata.Sphene.Eu_Err(end)=6900;
pdata.Sphene.Gd_Err(end)=3100;
pdata.Sphene.Tb_Err(end)=7500;
pdata.Sphene.Dy_Err(end)=3400;
pdata.Sphene.Ho_Err(end)=5100;
pdata.Sphene.Er_Err(end)=2800;
pdata.Sphene.Tm_Err(end)=2400;
pdata.Sphene.Yb_Err(end)=880;
pdata.Sphene.Lu_Err(end)=690;
pdata.Sphene.Pb_Err(end)=0.71;
pdata.Sphene.Th_Err(end)=37;
pdata.Sphene.U_Err(end)=32;


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

pdata.samples{end,1}='Olin, 2012';
pdata.samples{end,2}='Phonolite';
pdata.SiO2(end)=58;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=21;


pdata.Sphene.Y(end)=30;
pdata.Sphene.Zr(end)=7;
pdata.Sphene.Nb(end)=36;
pdata.Sphene.La(end)=25;
pdata.Sphene.Ce(end)=40;
pdata.Sphene.Pr(end)=55;
pdata.Sphene.Nd(end)=63;
pdata.Sphene.Sm(end)=72;
pdata.Sphene.Tb(end)=62;
pdata.Sphene.Dy(end)=55;
pdata.Sphene.Ho(end)=47;
pdata.Sphene.Er(end)=37;
pdata.Sphene.Tm(end)=28;
pdata.Sphene.Yb(end)=20;
pdata.Sphene.Lu(end)=13;
pdata.Sphene.Hf(end)=14;
pdata.Sphene.Ta(end)=110;
pdata.Sphene.Pb(end)=0.05;
pdata.Sphene.Th(end)=1.9;
pdata.Sphene.U(end)=1.1;

pdata.Sphene.Y_Err(end)=2.5;
pdata.Sphene.Zr_Err(end)=1;
pdata.Sphene.Nb_Err(end)=3;
pdata.Sphene.La_Err(end)=2.5;
pdata.Sphene.Ce_Err(end)=3.5;
pdata.Sphene.Pr_Err(end)=4.5;
pdata.Sphene.Nd_Err(end)=6.5;
pdata.Sphene.Sm_Err(end)=7.5;
pdata.Sphene.Tb_Err(end)=7;
pdata.Sphene.Dy_Err(end)=6;
pdata.Sphene.Ho_Err(end)=5;
pdata.Sphene.Er_Err(end)=4;
pdata.Sphene.Tm_Err(end)=3;
pdata.Sphene.Yb_Err(end)=2.5;
pdata.Sphene.Lu_Err(end)=1.5;
pdata.Sphene.Hf_Err(end)=3;
pdata.Sphene.Ta_Err(end)=13;
pdata.Sphene.Pb_Err(end)=0.01;
pdata.Sphene.Th_Err(end)=0.25;
pdata.Sphene.U_Err(end)=0.135;


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

pdata.samples{end,1}='Prowatke and Klemme, 2005';
pdata.samples{end,2}='ASI200';
pdata.SiO2(end)=55.88;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=4.72;

pdata.Sphene.Rb(end)=0.00034;
pdata.Sphene.Sr(end)=0.54;
pdata.Sphene.Y(end)=0.73;
pdata.Sphene.Zr(end)=2.65;
pdata.Sphene.Nb(end)=1.3;
pdata.Sphene.Cs(end)=0.0024;
pdata.Sphene.Ba(end)=0.0019;
pdata.Sphene.La(end)=0.4;
pdata.Sphene.Ce(end)=0.55;
pdata.Sphene.Pr(end)=0.83;
pdata.Sphene.Sm(end)=1.23;
pdata.Sphene.Gd(end)=1.09;
pdata.Sphene.Lu(end)=0.31;
pdata.Sphene.Hf(end)=3.07;
pdata.Sphene.Ta(end)=4.94;
pdata.Sphene.Pb(end)=0.25;
pdata.Sphene.Tb(end)=0.025;
pdata.Sphene.U(end)=0.07;

pdata.Sphene.Rb_Err(end)=0.00004;
pdata.Sphene.Sr_Err(end)=0.03;
pdata.Sphene.Y_Err(end)=0.02;
pdata.Sphene.Zr_Err(end)=0.1;
pdata.Sphene.Nb_Err(end)=0.1;
pdata.Sphene.Cs_Err(end)=0.0002;
pdata.Sphene.Ba_Err(end)=0.0003;
pdata.Sphene.La_Err(end)=0.02;
pdata.Sphene.Ce_Err(end)=0.02;
pdata.Sphene.Pr_Err(end)=0.02;
pdata.Sphene.Sm_Err(end)=0.04;
pdata.Sphene.Gd_Err(end)=0.04;
pdata.Sphene.Lu_Err(end)=0.02;
pdata.Sphene.Hf_Err(end)=0.1;
pdata.Sphene.Ta_Err(end)=0.22;
pdata.Sphene.Pb_Err(end)=0.05;
pdata.Sphene.Tb_Err(end)=0.03;
pdata.Sphene.U_Err(end)=0.01;


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

pdata.samples{end,1}='Prowatke and Klemme, 2005';
pdata.samples{end,2}='ASI220';
pdata.SiO2(end)=59.87;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=9.36;

pdata.Sphene.Rb(end)=0.00043;
pdata.Sphene.Sr(end)=0.61;
pdata.Sphene.Y(end)=1.53;
pdata.Sphene.Zr(end)=2.57;
pdata.Sphene.Nb(end)=2.81;
pdata.Sphene.Cs(end)=0.0024;
pdata.Sphene.Ba(end)=0.0021;
pdata.Sphene.La(end)=0.81;
pdata.Sphene.Ce(end)=1.21;
pdata.Sphene.Pr(end)=2.07;
pdata.Sphene.Sm(end)=3.44;
pdata.Sphene.Gd(end)=2.83;
pdata.Sphene.Lu(end)=0.55;
pdata.Sphene.Hf(end)=2.64;
pdata.Sphene.Ta(end)=9.9;
pdata.Sphene.Pb(end)=0.23;
pdata.Sphene.Tb(end)=0.045;
pdata.Sphene.U(end)=0.091;

pdata.Sphene.Rb_Err(end)=0.00011;
pdata.Sphene.Sr_Err(end)=0.04;
pdata.Sphene.Y_Err(end)=0.09;
pdata.Sphene.Zr_Err(end)=0.18;
pdata.Sphene.Nb_Err(end)=0.26;
pdata.Sphene.Cs_Err(end)=0.0004;
pdata.Sphene.Ba_Err(end)=0.0003;
pdata.Sphene.La_Err(end)=0.05;
pdata.Sphene.Ce_Err(end)=0.07;
pdata.Sphene.Pr_Err(end)=0.13;
pdata.Sphene.Sm_Err(end)=0.24;
pdata.Sphene.Gd_Err(end)=0.24;
pdata.Sphene.Lu_Err(end)=0.03;
pdata.Sphene.Hf_Err(end)=0.28;
pdata.Sphene.Ta_Err(end)=1.1;
pdata.Sphene.Pb_Err(end)=0.05;
pdata.Sphene.Tb_Err(end)=0.006;
pdata.Sphene.U_Err(end)=0.031;


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

pdata.samples{end,1}='Prowatke and Klemme, 2005';
pdata.samples{end,2}='ASI240';
pdata.SiO2(end)=61.67;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=14.62;

pdata.Sphene.Rb(end)=0.00025;
pdata.Sphene.Sr(end)=0.51;
pdata.Sphene.Y(end)=4.39;
pdata.Sphene.Zr(end)=3.32;
pdata.Sphene.Nb(end)=2.97;
pdata.Sphene.Cs(end)=0.0018;
pdata.Sphene.Ba(end)=0.0023;
pdata.Sphene.La(end)=1.38;
pdata.Sphene.Ce(end)=2.35;
pdata.Sphene.Pr(end)=4.55;
pdata.Sphene.Sm(end)=10.46;
pdata.Sphene.Gd(end)=9.06;
pdata.Sphene.Lu(end)=1.33;
pdata.Sphene.Hf(end)=4.71;
pdata.Sphene.Ta(end)=25.1;
pdata.Sphene.Pb(end)=0.4;
pdata.Sphene.Tb(end)=0.11;
pdata.Sphene.U(end)=0.1;

pdata.Sphene.Rb_Err(end)=0.00007;
pdata.Sphene.Sr_Err(end)=0.02;
pdata.Sphene.Y_Err(end)=0.24;
pdata.Sphene.Zr_Err(end)=0.38;
pdata.Sphene.Nb_Err(end)=0.17;
pdata.Sphene.Cs_Err(end)=0.0002;
pdata.Sphene.Ba_Err(end)=0.0001;
pdata.Sphene.La_Err(end)=0.13;
pdata.Sphene.Ce_Err(end)=0.18;
pdata.Sphene.Pr_Err(end)=0.25;
pdata.Sphene.Sm_Err(end)=0.63;
pdata.Sphene.Gd_Err(end)=0.67;
pdata.Sphene.Lu_Err(end)=0.09;
pdata.Sphene.Hf_Err(end)=0.39;
pdata.Sphene.Ta_Err(end)=0.33;
pdata.Sphene.Pb_Err(end)=0.08;
pdata.Sphene.Tb_Err(end)=0.01;
pdata.Sphene.U_Err(end)=0.02;


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

pdata.samples{end,1}='Prowatke and Klemme, 2005';
pdata.samples{end,2}='ASI250';
pdata.SiO2(end)=61.99;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=17.18;


pdata.Sphene.Rb(end)=0.00022;
pdata.Sphene.Sr(end)=0.45;
pdata.Sphene.Y(end)=18.5;
pdata.Sphene.Zr(end)=2.53;
pdata.Sphene.Nb(end)=4.42;
pdata.Sphene.Cs(end)=0.0017;
pdata.Sphene.Ba(end)=0.0022;
pdata.Sphene.La(end)=2.76;
pdata.Sphene.Ce(end)=6.09;
pdata.Sphene.Pr(end)=15.38;
pdata.Sphene.Sm(end)=59;
pdata.Sphene.Gd(end)=53.4;
pdata.Sphene.Lu(end)=3.56;
pdata.Sphene.Hf(end)=4.5;
pdata.Sphene.Ta(end)=63.5;
pdata.Sphene.Pb(end)=0.57;
pdata.Sphene.Tb(end)=0.23;
pdata.Sphene.U(end)=0.093;

pdata.Sphene.Rb_Err(end)=0.00008;
pdata.Sphene.Sr_Err(end)=0.02;
pdata.Sphene.Y_Err(end)=1.2;
pdata.Sphene.Zr_Err(end)=0.3;
pdata.Sphene.Nb_Err(end)=0.37;
pdata.Sphene.Cs_Err(end)=0.0003;
pdata.Sphene.Ba_Err(end)=0.0001;
pdata.Sphene.La_Err(end)=0.21;
pdata.Sphene.Ce_Err(end)=0.37;
pdata.Sphene.Pr_Err(end)=0.97;
pdata.Sphene.Sm_Err(end)=4.4;
pdata.Sphene.Gd_Err(end)=4.8;
pdata.Sphene.Lu_Err(end)=0.26;
pdata.Sphene.Hf_Err(end)=0.57;
pdata.Sphene.Ta_Err(end)=8.6;
pdata.Sphene.Pb_Err(end)=0.13;
pdata.Sphene.Tb_Err(end)=0.03;
pdata.Sphene.U_Err(end)=0.01;


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

pdata.samples{end,1}='Prowatke and Klemme, 2005';
pdata.samples{end,2}='ASI260';
pdata.SiO2(end)=61.37;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=19.18;


pdata.Sphene.Rb(end)=0.00019;
pdata.Sphene.Sr(end)=0.44;
pdata.Sphene.Y(end)=126;
pdata.Sphene.Zr(end)=2.46;
pdata.Sphene.Nb(end)=6.22;
pdata.Sphene.Cs(end)=0.0017;
pdata.Sphene.Ba(end)=0.0029;
pdata.Sphene.La(end)=5.17;
pdata.Sphene.Ce(end)=16.8;
pdata.Sphene.Pr(end)=58.3;
pdata.Sphene.Sm(end)=383;
pdata.Sphene.Gd(end)=416;
pdata.Sphene.Lu(end)=13.2;
pdata.Sphene.Hf(end)=4.84;
pdata.Sphene.Ta(end)=88;
pdata.Sphene.Pb(end)=0.88;
pdata.Sphene.Tb(end)=0.48;
pdata.Sphene.U(end)=0.104;

pdata.Sphene.Rb_Err(end)=0.00003;
pdata.Sphene.Sr_Err(end)=0.01;
pdata.Sphene.Y_Err(end)=11;
pdata.Sphene.Zr_Err(end)=0.26;
pdata.Sphene.Nb_Err(end)=0.53;
pdata.Sphene.Cs_Err(end)=0.0001;
pdata.Sphene.Ba_Err(end)=0.0001;
pdata.Sphene.La_Err(end)=0.59;
pdata.Sphene.Ce_Err(end)=0.18;
pdata.Sphene.Pr_Err(end)=5.9;
pdata.Sphene.Sm_Err(end)=46;
pdata.Sphene.Gd_Err(end)=51;
pdata.Sphene.Lu_Err(end)=1.3;
pdata.Sphene.Hf_Err(end)=0.62;
pdata.Sphene.Ta_Err(end)=17;
pdata.Sphene.Pb_Err(end)=0.23;
pdata.Sphene.Tb_Err(end)=0.09;
pdata.Sphene.U_Err(end)=0.006;


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

pdata.samples{end,1}='Prowatke and Klemme, 2005';
pdata.samples{end,2}='ASI280';
pdata.SiO2(end)=57.51;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=20.52;


pdata.Sphene.Rb(end)=0.00043;
pdata.Sphene.Sr(end)=0.48;
pdata.Sphene.Y(end)=246;
pdata.Sphene.Zr(end)=2.72;
pdata.Sphene.Nb(end)=6.5;
pdata.Sphene.Cs(end)=0.0032;
pdata.Sphene.Ba(end)=0.0055;
pdata.Sphene.La(end)=8.2;
pdata.Sphene.Ce(end)=28.4;
pdata.Sphene.Pr(end)=77;
pdata.Sphene.Sm(end)=364;
pdata.Sphene.Gd(end)=368;
pdata.Sphene.Lu(end)=50;
pdata.Sphene.Hf(end)=4.74;
pdata.Sphene.Ta(end)=41;
pdata.Sphene.Pb(end)=0.61;
pdata.Sphene.Tb(end)=3.55;
pdata.Sphene.U(end)=0.39;

pdata.Sphene.Rb_Err(end)=0.0004;
pdata.Sphene.Sr_Err(end)=0.01;
pdata.Sphene.Y_Err(end)=39;
pdata.Sphene.Zr_Err(end)=0.39;
pdata.Sphene.Nb_Err(end)=3.7;
pdata.Sphene.Cs_Err(end)=0.003;
pdata.Sphene.Ba_Err(end)=0.005;
pdata.Sphene.La_Err(end)=2.2;
pdata.Sphene.Ce_Err(end)=3.3;
pdata.Sphene.Pr_Err(end)=11;
pdata.Sphene.Sm_Err(end)=85;
pdata.Sphene.Gd_Err(end)=58;
pdata.Sphene.Lu_Err(end)=6;
pdata.Sphene.Hf_Err(end)=0.52;
pdata.Sphene.Ta_Err(end)=19;
pdata.Sphene.Pb_Err(end)=0.16;
pdata.Sphene.Tb_Err(end)=0.3;
pdata.Sphene.U_Err(end)=0.04;


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

pdata.samples{end,1}='Prowatke and Klemme, 2005';
pdata.samples{end,2}='Dacite';
pdata.SiO2(end)=62.8;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=16.19;


pdata.Sphene.Rb(end)=0.00026;
pdata.Sphene.Sr(end)=0.62;
pdata.Sphene.Y(end)=14.3;
pdata.Sphene.Zr(end)=3.78;
pdata.Sphene.Nb(end)=7.26;
pdata.Sphene.Cs(end)=0.0023;
pdata.Sphene.Ba(end)=0.0025;
pdata.Sphene.La(end)=2.17;
pdata.Sphene.Ce(end)=4.6;
pdata.Sphene.Pr(end)=9.7;
pdata.Sphene.Sm(end)=31.2;
pdata.Sphene.Gd(end)=30.5;
pdata.Sphene.Lu(end)=3.65;
pdata.Sphene.Hf(end)=6.9;
pdata.Sphene.Ta(end)=84;
pdata.Sphene.Pb(end)=0.87;
pdata.Sphene.Tb(end)=0.28;
pdata.Sphene.U(end)=0.14;

pdata.Sphene.Rb_Err(end)=0.00004;
pdata.Sphene.Sr_Err(end)=0.03;
pdata.Sphene.Y_Err(end)=1.7;
pdata.Sphene.Zr_Err(end)=0.57;
pdata.Sphene.Nb_Err(end)=0.73;
pdata.Sphene.Cs_Err(end)=0.0005;
pdata.Sphene.Ba_Err(end)=0.0002;
pdata.Sphene.La_Err(end)=0.38;
pdata.Sphene.Ce_Err(end)=0.72;
pdata.Sphene.Pr_Err(end)=1.2;
pdata.Sphene.Sm_Err(end)=4;
pdata.Sphene.Gd_Err(end)=3.9;
pdata.Sphene.Lu_Err(end)=0.51;
pdata.Sphene.Hf_Err(end)=1.4;
pdata.Sphene.Ta_Err(end)=14;
pdata.Sphene.Pb_Err(end)=0.17;
pdata.Sphene.Tb_Err(end)=0.08;
pdata.Sphene.U_Err(end)=0.02;


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

pdata.samples{end,1}='Prowatke and Klemme, 2005';
pdata.samples{end,2}='Rhyolite';
pdata.SiO2(end)=67.22;
pdata.SiO2_Err(end)=5;
% pdata.Al2O3(end)=13.81;


pdata.Sphene.Rb(end)=0.00033;
pdata.Sphene.Sr(end)=0.44;
pdata.Sphene.Y(end)=8.69;
pdata.Sphene.Zr(end)=3.48;
pdata.Sphene.Nb(end)=5.44;
pdata.Sphene.Cs(end)=0.0022;
pdata.Sphene.Ba(end)=0.0029;
pdata.Sphene.La(end)=1.88;
pdata.Sphene.Ce(end)=3.61;
pdata.Sphene.Pr(end)=7.39;
pdata.Sphene.Sm(end)=20.4;
pdata.Sphene.Gd(end)=18.2;
pdata.Sphene.Lu(end)=2.38;
pdata.Sphene.Hf(end)=4.9;
pdata.Sphene.Ta(end)=54.8;
pdata.Sphene.Pb(end)=0.75;
pdata.Sphene.Tb(end)=0.15;
pdata.Sphene.U(end)=0.101;

pdata.Sphene.Rb_Err(end)=0.00003;
pdata.Sphene.Sr_Err(end)=0.01;
pdata.Sphene.Y_Err(end)=0.48;
pdata.Sphene.Zr_Err(end)=0.47;
pdata.Sphene.Nb_Err(end)=0.1;
pdata.Sphene.Cs_Err(end)=0.0001;
pdata.Sphene.Ba_Err(end)=0.0001;
pdata.Sphene.La_Err(end)=0.08;
pdata.Sphene.Ce_Err(end)=0.19;
pdata.Sphene.Pr_Err(end)=0.45;
pdata.Sphene.Sm_Err(end)=1.4;
pdata.Sphene.Gd_Err(end)=1.5;
pdata.Sphene.Lu_Err(end)=0.08;
pdata.Sphene.Hf_Err(end)=0.71;
pdata.Sphene.Ta_Err(end)=7.2;
pdata.Sphene.Pb_Err(end)=0.16;
pdata.Sphene.Tb_Err(end)=0.01;
pdata.Sphene.U_Err(end)=0.008;



for m=pdata.minerals'
    for e=pdata.(m{1}).elements(1:length(pdata.Sphene.elements)/2)'
        % Convert standard errors to log scale
        pdata.(m{1}).([e{1} '_Err'])(end)=log10(pdata.(m{1}).(e{1})(end)+pdata.(m{1}).([e{1} '_Err'])(end)) - log10(pdata.(m{1}).(e{1})(end));
        % Convert values to log scale
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end