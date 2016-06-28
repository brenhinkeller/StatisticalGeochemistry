function dataout=bsresample(data, err2srel, nrows)
% Non-weighted bootstrap resample a variable up to size nrows
dataout=zeros(nrows,size(data,2));

i=1;
while i<=nrows
    
    if size(data,1)>1
        % select weighted sample of data
        p50=rand(size(data,1),1)>0.5;
        sdata=data(p50,:);
        serr=err2srel(p50,:);
    else
        sdata=data(:,:);
        serr=err2srel(:,:);
    end
    
    % Randomize data over uncertainty interval
    rn=randn(size(sdata));
    sdata=sdata+rn.*serr./2.*sdata;
    
    if i+size(sdata,1)-1<=nrows
        dataout(i:i+size(sdata,1)-1,:)=sdata;
    else
        dataout(i:end,:)=sdata(1:nrows-i+1,:);
    end
    i=i+size(sdata,1);
end
