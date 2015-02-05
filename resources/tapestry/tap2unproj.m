load tapestry

y=fliplr(5:0.01:85)';
x=-180:0.01:-45;

lat=repmat(y,1,length(x));
lon=repmat(x,length(y),1);


color=zeros(size(lat),'uint8');
tic;
ages=findtapestryage(lat(:),lon(:),tapestry);
toc

color(:)=ages(:,1);

figure; imagesc(color)