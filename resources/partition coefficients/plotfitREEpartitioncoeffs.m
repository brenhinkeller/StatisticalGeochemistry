%% Plot REE partition coeffs
figure;

ree={'La','Ce','Pr','Nd','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu'};

r=[0.106 0.103 0.101 0.100 0.096 0.095 0.094 0.092 0.091 0.089 0.088 0.087 0.086 0.085];

for i=1:length(pdata.SiO2)
    kD=NaN(1,14);
    for j=1:14;
        kD(j)=pdata.Orthoclase.(ree{j})(i);
    end
    hold on; plot(r,kD)
    if sum(~isnan(kD))>5
        pause
    end
end



%%

ree3={'La','Ce','Pr','Nd','Sm','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu'};
r=[0.106 0.103 0.101 0.100 0.096 0.094 0.092 0.091 0.089 0.088 0.087 0.086 0.085]';
rp=0.085:0.001:0.107;

g=fittype('lnD0 + a * (r0/2*(x-r0)^2 + 1/3*(x-r0)^3)'); % Where a=4piENa/RT


figure;
for i=1:length(pdata.SiO2)
    kD=NaN(13,1);
    for j=1:13;
        kD(j)=pdata.Garnet.(ree3{j})(i);
    end
    
    hold on; plot(r,kD)
    
    if sum(~isnan(kD))>3 && range(r(~isnan(kD)))>0.015
        f=fit(r(~isnan(kD)),kD(~isnan(kD)),g,'StartPoint',[-100000,max(kD),0.095]);
        hold on; plot(rp,f.lnD0 + f.a .* (f.r0./2.*(rp-f.r0).^2 + 1./3.*(rp-f.r0).^3),'r')
        
    end
end
