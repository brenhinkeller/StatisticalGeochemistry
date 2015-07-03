% Convert from row-based to Si-based struct

% Fit REEs as a function of activation energy and bulk modulus using the
% equation of Blundy and Wood, 1994
ree3={'La','Ce','Pr','Nd','Sm','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu'}; % 3+ rare earth elements
r=[0.106 0.103 0.101 0.100 0.096 0.094 0.092 0.091 0.089 0.088 0.087 0.086 0.085]'; % Atomic Radii
rp=0.085:0.001:0.107; % Radius range to plot over
g=fittype('lnD0 + a * (r0/2*(x-r0)^2 + 1/3*(x-r0)^3)'); % Equation we're fitting to, where a=4piENa/RT
% for mineral={'Apatite','Amphibole','Clinopyroxene','Orthopyroxene','Garnet','Sphene','Allanite','Baddeleyite'}
for mineral=pdata.minerals'
    figure;
    title(mineral)
    for i=1:length(pdata.SiO2)
        kD=NaN(13,1);
        for j=1:13;
            kD(j)=pdata.(mineral{1}).(ree3{j})(i);
        end
        hold on; plot(r,kD)
        
        if sum(~isnan(kD))>3 && range(r(~isnan(kD)))>0.015
            f=fit(r(~isnan(kD)),kD(~isnan(kD)),g,'StartPoint',[-100000,max(kD),0.095]);
            hold on; plot(rp,f.lnD0 + f.a .* (f.r0./2.*(rp-f.r0).^2 + 1./3.*(rp-f.r0).^3),'r')
            
            for j=1:13;
                pdata.(mineral{1}).(ree3{j})(i)=f.lnD0 + f.a .* (f.r0./2.*(r(j)-f.r0).^2 + 1./3.*(r(j)-f.r0).^3);
            end
        end
    end
end

% Interpolate Eu partition coefficients given 60% Eu as Eu2+ and 40% as Eu3+
% for mineral={'Albite','Anorthite','Orthoclase','Apatite'}
for mineral=pdata.minerals'
    for i=1:length(pdata.SiO2) 
        if isnan(pdata.(mineral{1}).Eu(i))
            pdata.(mineral{1}).Eu(i)=log10(0.6*10.^nanmean([pdata.(mineral{1}).Ba(i) pdata.(mineral{1}).Sr(i)],2) + 0.4*10.^nanmean([pdata.(mineral{1}).Sm(i) pdata.(mineral{1}).Gd(i)],2));
        end
    end
end


% Convert
tic;
minerals=pdata.minerals;
elements=pdata.(minerals{1}).elements;
p.minerals=minerals;
for i=1:length(pdata.minerals)
    for j=1:length(pdata.(pdata.minerals{i}).elements)/2
        p.(minerals{i}).elements=elements;
        if range(pdata.SiO2(~isnan(pdata.(minerals{i}).(elements{j})))) > 5
            p.(minerals{i}).(elements{j})=monteCarloFit(pdata.SiO2, pdata.SiO2_Err, pdata.(minerals{i}).(elements{j}), pdata.(minerals{i}).([elements{j} '_Err']), 40,80,41,5);
        else
            p.(minerals{i}).(elements{j})=ones(41,1).*nanmean(pdata.(minerals{i}).(elements{j}));
        end
        p.(minerals{i}).([elements{j} '_Err'])=nanvar(pdata.(minerals{i}).(elements{j}));
    end
end
p.SiO2=40:80;
toc


for e=p.Albite.elements'
    p.Albite.(e{1})=nanmean([p.Albite.(e{1}) p.Orthoclase.(e{1}) p.Anorthite.(e{1})],2);
end
p.note='p.Albite is nanmean of p.AlkaliFeldspar, p.Orthoclase, and p.Anorthite';


% % Very slow?
% clear pdata
% pdata.data=p;
% pdata.minerals=minerals;
% for i=1:length(minerals)
%     for j=1:length(elements)/2
%         pdata.(minerals{i}).elements=elements;
%         pdata.(minerals{i}).(elements{j})=@(x) pdata.data.(minerals{i}).(elements{j})(round(x)-39);
%         pdata.(minerals{i}).([elements{j} '_Err'])=pdata.data.(minerals{i}).([elements{j} '_Err']);
%     end
% end




%% Remove data from single experimental study (if low quality data or unusual bulk composition)
% column=16;
% 
% for m=pdata.minerals'
%     for e=pdata.(m{1}).elements'
%         pdata.(m{1}).(e{1})(column)=[];
%     end
% end
% 
% pdata.samples(column,:)=[];
% pdata.SiO2(column)=[];
% pdata.SiO2_Err(column)=[];