function out=cestar(in)
x=[1 3 5 6 7];
y=log([in.Sm/0.1530 in.Nd/0.4670 in.Pr/0.0950 in.La/0.2370 in.Ba/2.410]); % normalize to chondrite
out=NaN(size(in.Ce));
for i=1:length(out)
    values=~isnan(y(i,:));
    if sum(values)>1
        p=polyfit(x(values),y(i,values),1);
        out(i)=0.6120*exp(5*p(1)+p(2)); % de-normalize output
    end
end