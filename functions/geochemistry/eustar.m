function out=eustar(in)

x=[1 2 4 6];
y=log([in.Tb/0.0374 in.Gd/0.2055 in.Sm/0.1530 in.Nd/0.4670]); % normalize to chondrite
out=NaN(size(in.Eu));
for i=1:length(out)
    values=~isnan(y(i,:));
    if sum(values)>1
        p=polyfit(x(values),y(i,values),1);
        out(i)=0.0580*exp(3*p(1)+p(2)); % de-normalize output
    end
end

