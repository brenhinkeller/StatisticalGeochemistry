%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='72'
% pdata.SiO2(end)=52.89
pdata.SiO2(end)=44.08
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0013
pdata.Apatite.Sr(end)=2.43
pdata.Apatite.Y(end)=2.58
pdata.Apatite.Zr(end)=0.030
pdata.Apatite.Nb(end)=0.0012
pdata.Apatite.Cs(end)=0.0002
pdata.Apatite.Ba(end)=0.10
pdata.Apatite.La(end)=4.85
pdata.Apatite.Ce(end)=4.92
pdata.Apatite.Pr(end)=5.43
pdata.Apatite.Sm(end)=6.22
pdata.Apatite.Gd(end)=5.31
pdata.Apatite.Lu(end)=1.03
pdata.Apatite.Hf(end)=0.0065
pdata.Apatite.Ta(end)=0.0012
pdata.Apatite.Pb(end)=0.64
pdata.Apatite.Th(end)=0.5
pdata.Apatite.U(end)=0.53



pdata.Apatite.Rb_Err(end)=0.0001
pdata.Apatite.Sr_Err(end)=0.12
pdata.Apatite.Y_Err(end)=0.03
pdata.Apatite.Zr_Err(end)=0.001
pdata.Apatite.Nb_Err(end)=0.0001
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.01
pdata.Apatite.La_Err(end)=0.04
pdata.Apatite.Ce_Err(end)=0.13
pdata.Apatite.Pr_Err(end)=0.01
pdata.Apatite.Sm_Err(end)=0.23
pdata.Apatite.Gd_Err(end)=0.16
pdata.Apatite.Lu_Err(end)=0.06
pdata.Apatite.Hf_Err(end)=0.0013
pdata.Apatite.Ta_Err(end)=0.0001
pdata.Apatite.Pb_Err(end)=0.11
pdata.Apatite.Th_Err(end)=0.02
pdata.Apatite.U_Err(end)=0.02





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end



%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='78'
% pdata.SiO2(end)=56.80  
pdata.SiO2(end)=46.45
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0016
pdata.Apatite.Sr(end)=3.72
pdata.Apatite.Y(end)=3.82
pdata.Apatite.Zr(end)=0.041
pdata.Apatite.Nb(end)=0.0018
pdata.Apatite.Cs(end)=0.0002
pdata.Apatite.Ba(end)=0.14
pdata.Apatite.La(end)=8.33
pdata.Apatite.Ce(end)=8.49
pdata.Apatite.Pr(end)=9.68
pdata.Apatite.Sm(end)=11.4
pdata.Apatite.Gd(end)=9.12
pdata.Apatite.Lu(end)=1.39
pdata.Apatite.Hf(end)=0.013
pdata.Apatite.Ta(end)=0.0014
pdata.Apatite.Pb(end)=0.48
pdata.Apatite.Th(end)=0.64
pdata.Apatite.U(end)=0.25



pdata.Apatite.Rb_Err(end)=0.0001
pdata.Apatite.Sr_Err(end)=0.25
pdata.Apatite.Y_Err(end)=0.16
pdata.Apatite.Zr_Err(end)=0.001
pdata.Apatite.Nb_Err(end)=0.0001
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.01
pdata.Apatite.La_Err(end)=0.27
pdata.Apatite.Ce_Err(end)=0.28
pdata.Apatite.Pr_Err(end)=0.33
pdata.Apatite.Sm_Err(end)=0.21
pdata.Apatite.Gd_Err(end)=0.08
pdata.Apatite.Lu_Err(end)=0.08
pdata.Apatite.Hf_Err(end)=0.002
pdata.Apatite.Ta_Err(end)=0.0005
pdata.Apatite.Pb_Err(end)=0.05
pdata.Apatite.Th_Err(end)=0.03
pdata.Apatite.U_Err(end)=0.02





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end


%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='77'
% pdata.SiO2(end)=56.16  
pdata.SiO2(end)=48.27
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0009
pdata.Apatite.Sr(end)=5.10
pdata.Apatite.Y(end)=8.73
pdata.Apatite.Zr(end)=0.047
pdata.Apatite.Nb(end)=0.0023
pdata.Apatite.Cs(end)=0.0001
pdata.Apatite.Ba(end)=0.14
pdata.Apatite.La(end)=16.6
pdata.Apatite.Ce(end)=18.1
pdata.Apatite.Pr(end)=20.6
pdata.Apatite.Sm(end)=25.7
pdata.Apatite.Gd(end)=21.5
pdata.Apatite.Lu(end)=3.01
pdata.Apatite.Hf(end)=0.012
pdata.Apatite.Ta(end)=0.0023
pdata.Apatite.Pb(end)=0.94
pdata.Apatite.Th(end)=1.08
pdata.Apatite.U(end)=0.08




pdata.Apatite.Rb_Err(end)=0.0003
pdata.Apatite.Sr_Err(end)=0.38
pdata.Apatite.Y_Err(end)=0.63
pdata.Apatite.Zr_Err(end)=0.004
pdata.Apatite.Nb_Err(end)=0.0002
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.02
pdata.Apatite.La_Err(end)=0.7
pdata.Apatite.Ce_Err(end)=1.5
pdata.Apatite.Pr_Err(end)=1.3
pdata.Apatite.Sm_Err(end)=1.7
pdata.Apatite.Gd_Err(end)=0.7
pdata.Apatite.Lu_Err(end)=0.26
pdata.Apatite.Hf_Err(end)=0.001
pdata.Apatite.Ta_Err(end)=0.0002
pdata.Apatite.Pb_Err(end)=0.19
pdata.Apatite.Th_Err(end)=0.07
pdata.Apatite.U_Err(end)=0.01





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end


%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='61B'
% pdata.SiO2(end)=61.51  
pdata.SiO2(end)=53.55
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0010
pdata.Apatite.Sr(end)=4.3
pdata.Apatite.Y(end)=7.1
pdata.Apatite.Zr(end)=0.042
pdata.Apatite.Nb(end)=0.0011
pdata.Apatite.Cs(end)=0.0001
pdata.Apatite.Ba(end)=0.12
pdata.Apatite.La(end)=11.4
pdata.Apatite.Ce(end)=12.9
pdata.Apatite.Pr(end)=13.5
pdata.Apatite.Sm(end)=16.9
pdata.Apatite.Gd(end)=13.9
pdata.Apatite.Lu(end)=3.92
pdata.Apatite.Hf(end)=0.014
pdata.Apatite.Ta(end)=0.0030
pdata.Apatite.Pb(end)=0.84
pdata.Apatite.Th(end)=1.28
pdata.Apatite.U(end)=1.4




pdata.Apatite.Rb_Err(end)=0.0003
pdata.Apatite.Sr_Err(end)=0.3
pdata.Apatite.Y_Err(end)=0.3
pdata.Apatite.Zr_Err(end)=0.003
pdata.Apatite.Nb_Err(end)=0.0003
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.03
pdata.Apatite.La_Err(end)=0.7
pdata.Apatite.Ce_Err(end)=1.5
pdata.Apatite.Pr_Err(end)=1.3
pdata.Apatite.Sm_Err(end)=1.7
pdata.Apatite.Gd_Err(end)=0.7
pdata.Apatite.Lu_Err(end)=0.26
pdata.Apatite.Hf_Err(end)=0.003
pdata.Apatite.Ta_Err(end)=0.0003
pdata.Apatite.Pb_Err(end)=0.2
pdata.Apatite.Th_Err(end)=0.2
pdata.Apatite.U_Err(end)=0.3





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end


%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='71A'
% pdata.SiO2(end)=50.15  
pdata.SiO2(end)=40.13
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0030
pdata.Apatite.Sr(end)=1.45
pdata.Apatite.Y(end)=1.66
pdata.Apatite.Zr(end)=0.078
pdata.Apatite.Nb(end)=0.0035
pdata.Apatite.Cs(end)=0.0002
pdata.Apatite.Ba(end)=0.06
pdata.Apatite.La(end)=1.91
pdata.Apatite.Ce(end)=2.33
pdata.Apatite.Pr(end)=2.67
pdata.Apatite.Sm(end)=3.66
pdata.Apatite.Gd(end)=2.97
pdata.Apatite.Lu(end)=0.70
pdata.Apatite.Hf(end)=0.020
pdata.Apatite.Ta(end)=0.0026
pdata.Apatite.Pb(end)=0.29
pdata.Apatite.Th(end)=0.97
pdata.Apatite.U(end)=0.46




pdata.Apatite.Rb_Err(end)=0.0005
pdata.Apatite.Sr_Err(end)=0.01
pdata.Apatite.Y_Err(end)=0.07
pdata.Apatite.Zr_Err(end)=0.001
pdata.Apatite.Nb_Err(end)=0.0017
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.01
pdata.Apatite.La_Err(end)=0.11
pdata.Apatite.Ce_Err(end)=0.07
pdata.Apatite.Pr_Err(end)=0.12
pdata.Apatite.Sm_Err(end)=0.14
pdata.Apatite.Gd_Err(end)=0.11
pdata.Apatite.Lu_Err(end)=0.04
pdata.Apatite.Hf_Err(end)=0.001
pdata.Apatite.Ta_Err(end)=0.0012
pdata.Apatite.Pb_Err(end)=0.08
pdata.Apatite.Th_Err(end)=0.02
pdata.Apatite.U_Err(end)=0.05





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end

%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='61A'
% pdata.SiO2(end)=47.25  
pdata.SiO2(end)=40.13
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0010
pdata.Apatite.Sr(end)=1.37
pdata.Apatite.Y(end)=2.91
pdata.Apatite.Zr(end)=0.056
pdata.Apatite.Nb(end)=0.0024
pdata.Apatite.Cs(end)=0.0001
pdata.Apatite.Ba(end)=0.06
pdata.Apatite.La(end)=2.94
pdata.Apatite.Ce(end)=3.23
pdata.Apatite.Pr(end)=3.86
pdata.Apatite.Sm(end)=5.68
pdata.Apatite.Gd(end)=5.13
pdata.Apatite.Lu(end)=1.22
pdata.Apatite.Hf(end)=0.014
pdata.Apatite.Ta(end)=0.0013
pdata.Apatite.Pb(end)=0.10
pdata.Apatite.Th(end)=0.70
pdata.Apatite.U(end)=0.17




pdata.Apatite.Rb_Err(end)=0.0001
pdata.Apatite.Sr_Err(end)=0.02
pdata.Apatite.Y_Err(end)=0.08
pdata.Apatite.Zr_Err(end)=0.002
pdata.Apatite.Nb_Err(end)=0.0017
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.01
pdata.Apatite.La_Err(end)=0.10
pdata.Apatite.Ce_Err(end)=0.44
pdata.Apatite.Pr_Err(end)=0.14
pdata.Apatite.Sm_Err(end)=0.25
pdata.Apatite.Gd_Err(end)=0.09
pdata.Apatite.Lu_Err(end)=0.08
pdata.Apatite.Hf_Err(end)=0.008
pdata.Apatite.Ta_Err(end)=0.0003
pdata.Apatite.Pb_Err(end)=0.01
pdata.Apatite.Th_Err(end)=0.03
pdata.Apatite.U_Err(end)=0.01





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end


%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='48B'
% pdata.SiO2(end)=40.70  
pdata.SiO2(end)=29.9
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0006
pdata.Apatite.Sr(end)=1.10
pdata.Apatite.Y(end)=2.83
pdata.Apatite.Zr(end)=0.027
pdata.Apatite.Nb(end)=0.0012
pdata.Apatite.Cs(end)=0.0001
pdata.Apatite.Ba(end)=0.06
pdata.Apatite.La(end)=2.80
pdata.Apatite.Ce(end)=3.25
pdata.Apatite.Pr(end)=3.67
pdata.Apatite.Sm(end)=4.99
pdata.Apatite.Gd(end)=4.65
pdata.Apatite.Lu(end)=1.14
pdata.Apatite.Hf(end)=0.010
pdata.Apatite.Ta(end)=0.0010
pdata.Apatite.Pb(end)=0.39
pdata.Apatite.Th(end)=0.33
pdata.Apatite.U(end)=0.48




pdata.Apatite.Rb_Err(end)=0.0001
pdata.Apatite.Sr_Err(end)=0.01
pdata.Apatite.Y_Err(end)=0.05
pdata.Apatite.Zr_Err(end)=0.001
pdata.Apatite.Nb_Err(end)=0.0001
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.01
pdata.Apatite.La_Err(end)=0.04
pdata.Apatite.Ce_Err(end)=0.05
pdata.Apatite.Pr_Err(end)=0.02
pdata.Apatite.Sm_Err(end)=0.10
pdata.Apatite.Gd_Err(end)=0.16
pdata.Apatite.Lu_Err(end)=0.03
pdata.Apatite.Hf_Err(end)=0.001
pdata.Apatite.Ta_Err(end)=0.0001
pdata.Apatite.Pb_Err(end)=0.03
pdata.Apatite.Th_Err(end)=0.01
pdata.Apatite.U_Err(end)=0.02





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end

%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='59B'
% pdata.SiO2(end)=44.67  
pdata.SiO2(end)=37.45
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0007
pdata.Apatite.Sr(end)=1.56
pdata.Apatite.Y(end)=3.92
pdata.Apatite.Zr(end)=0.069
pdata.Apatite.Nb(end)=0.0022
pdata.Apatite.Cs(end)=0.0002
pdata.Apatite.Ba(end)=0.05
pdata.Apatite.La(end)=4.32
pdata.Apatite.Ce(end)=5.17
pdata.Apatite.Pr(end)=5.94
pdata.Apatite.Sm(end)=8.25
pdata.Apatite.Gd(end)=7.44
pdata.Apatite.Lu(end)=1.62
pdata.Apatite.Hf(end)=0.016
pdata.Apatite.Ta(end)=0.0017
pdata.Apatite.Pb(end)=0.19
pdata.Apatite.Th(end)=0.95
pdata.Apatite.U(end)=0.70




pdata.Apatite.Rb_Err(end)=0.0001
pdata.Apatite.Sr_Err(end)=0.05
pdata.Apatite.Y_Err(end)=0.20
pdata.Apatite.Zr_Err(end)=0.002
pdata.Apatite.Nb_Err(end)=0.0001
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.01
pdata.Apatite.La_Err(end)=0.26
pdata.Apatite.Ce_Err(end)=0.32
pdata.Apatite.Pr_Err(end)=0.37
pdata.Apatite.Sm_Err(end)=0.57
pdata.Apatite.Gd_Err(end)=0.54
pdata.Apatite.Lu_Err(end)=0.07
pdata.Apatite.Hf_Err(end)=0.001
pdata.Apatite.Ta_Err(end)=0.0001
pdata.Apatite.Pb_Err(end)=0.04
pdata.Apatite.Th_Err(end)=0.05
pdata.Apatite.U_Err(end)=0.04





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end

%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='43'
% pdata.SiO2(end)=57.15  
pdata.SiO2(end)=46.79
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0004
pdata.Apatite.Sr(end)=3.79
pdata.Apatite.Y(end)=5.69
pdata.Apatite.Zr(end)=0.020
pdata.Apatite.Nb(end)=0.0011
pdata.Apatite.Cs(end)=0.0002
pdata.Apatite.Ba(end)=0.16
pdata.Apatite.La(end)=13.3
pdata.Apatite.Ce(end)=13.6
pdata.Apatite.Pr(end)=14.6
pdata.Apatite.Sm(end)=16.4
pdata.Apatite.Gd(end)=13.3
pdata.Apatite.Lu(end)=2.05
pdata.Apatite.Hf(end)=0.0073
pdata.Apatite.Ta(end)=0.0014
pdata.Apatite.Pb(end)=0.62
pdata.Apatite.Th(end)=0.40
pdata.Apatite.U(end)=0.35




pdata.Apatite.Rb_Err(end)=0.0002
pdata.Apatite.Sr_Err(end)=0.14
pdata.Apatite.Y_Err(end)=0.27
pdata.Apatite.Zr_Err(end)=0.001
pdata.Apatite.Nb_Err(end)=0.0001
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.01
pdata.Apatite.La_Err(end)=1.0
pdata.Apatite.Ce_Err(end)=1.3
pdata.Apatite.Pr_Err(end)=1.6
pdata.Apatite.Sm_Err(end)=2.4
pdata.Apatite.Gd_Err(end)=0.9
pdata.Apatite.Lu_Err(end)=0.06
pdata.Apatite.Hf_Err(end)=0.0002
pdata.Apatite.Ta_Err(end)=0.0001
pdata.Apatite.Pb_Err(end)=0.05
pdata.Apatite.Th_Err(end)=0.01
pdata.Apatite.U_Err(end)=0.01





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end


%% Add a column
for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})=[pdata.(m{1}).(e{1}); NaN];
    end
end
pdata.SiO2=[pdata.SiO2; NaN];
pdata.SiO2_Err=[pdata.SiO2_Err; NaN];
pdata.samples=[pdata.samples; cell(1,2)];


pdata.samples{end,1}='Prowatke and Klemme, 2006'



pdata.samples{end,2}='54A'
% pdata.SiO2(end)=59.00  
pdata.SiO2(end)=49.11
pdata.SiO2_Err(end)=5




pdata.Apatite.Rb(end)=0.0007
pdata.Apatite.Sr(end)=4.59
pdata.Apatite.Y(end)=8.43
pdata.Apatite.Zr(end)=0.030
pdata.Apatite.Nb(end)=0.0013
pdata.Apatite.Cs(end)=0.0002
pdata.Apatite.Ba(end)=0.18
pdata.Apatite.La(end)=19.7
pdata.Apatite.Ce(end)=20.2
pdata.Apatite.Pr(end)=23.6
pdata.Apatite.Sm(end)=28.3
pdata.Apatite.Gd(end)=22.1
pdata.Apatite.Lu(end)=2.94
pdata.Apatite.Hf(end)=0.0088
pdata.Apatite.Ta(end)=0.0016
pdata.Apatite.Pb(end)=2.10
pdata.Apatite.Th(end)=0.47
pdata.Apatite.U(end)=0.34




pdata.Apatite.Rb_Err(end)=0.0001
pdata.Apatite.Sr_Err(end)=0.24
pdata.Apatite.Y_Err(end)=0.27
pdata.Apatite.Zr_Err(end)=0.002
pdata.Apatite.Nb_Err(end)=0.0007
pdata.Apatite.Cs_Err(end)=0.0001
pdata.Apatite.Ba_Err(end)=0.01
pdata.Apatite.La_Err(end)=1.1
pdata.Apatite.Ce_Err(end)=1.4
pdata.Apatite.Pr_Err(end)=2.1
pdata.Apatite.Sm_Err(end)=2.9
pdata.Apatite.Gd_Err(end)=2.3
pdata.Apatite.Lu_Err(end)=0.08
pdata.Apatite.Hf_Err(end)=0.0020
pdata.Apatite.Ta_Err(end)=0.0001
pdata.Apatite.Pb_Err(end)=0.51
pdata.Apatite.Th_Err(end)=0.01
pdata.Apatite.U_Err(end)=0.01





for m=pdata.minerals'
    for e=pdata.(m{1}).elements'
        pdata.(m{1}).(e{1})(end)=log10(pdata.(m{1}).(e{1})(end));
    end
end
