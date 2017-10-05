function dataout=bsresampleunif(data, err, nrows)
% dataout=bsresample(data, err2srel, nrows)
% Non-weighted bootstrap resample a variable up to size nrows

dataout=zeros(nrows,size(data,2));

i=1;
while i<=nrows
    
    if size(data,1)>1
        % select weighted sample of data
        p50=rand(size(data,1),1)>0.5;
        sdata=data(p50,:);
        
        % Corresponing uncertainty (either blanket or for each datum)
        if size(err,1)>1
            serr=err(p50,:);
        else
            serr=ones(size(sdata)).*err;
        end
    else
        sdata=data;
        serr=err;
    end
    
    % Randomize data over uncertainty interval
    rn=rand(size(sdata))-0.5;
    sdata=sdata+rn.*serr./2.*sdata;
    
    if i+size(sdata,1)-1<=nrows
        dataout(i:i+size(sdata,1)-1,:)=sdata;
    else
        dataout(i:end,:)=sdata(1:nrows-i+1,:);
    end
    i=i+size(sdata,1);
end
