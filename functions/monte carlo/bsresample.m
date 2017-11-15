function dataout=bsresample(data, err2srel, nrows, varargin)
% dataout=bsresample(data, err2srel, nrows)
% Non-weighted bootstrap resample a variable up to size nrows

dataout=zeros(nrows,size(data,2));

if nargin == 4
    p = varargin{1};
else
    p = 0.5;
end

i=1;
while i<=nrows
    
    if size(data,1)>1
        % select weighted sample of data
        t=rand(size(data,1),1)<p;
        sdata=data(t,:);
        
        % Corresponing uncertainty (either blanket or for each datum)
        if size(err2srel,1)>1
            serr=err2srel(t,:);
        else
            serr=ones(size(sdata)).*err2srel;
        end
    else
        sdata=data;
        serr=err2srel;
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
