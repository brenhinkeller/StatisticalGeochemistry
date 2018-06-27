function [x,y]=digitizePlotCurveImageBounds(filename, colors, types, xmin, xmax, ymin, ymax, varargin)
    
    % Load the image
    A=imread(filename);
    A=int16(A);

    height = size(A,1);
    width = size(A,2);

    lineimage=zeros(height,width);
    for i=1:height
        for j=1:width
            [~,bestcolor]=min(sum([colors(:,1)-A(i,j,1) colors(:,2)-A(i,j,2) colors(:,3)-A(i,j,3)].^2,2));
            lineimage(i,j)=types(bestcolor);
        end
    end

    lineimage=flipud(lineimage);

    if nargin==8 && strcmp(varargin{1},'HorizontalFirst')
        % Find middle of line for each horizontal slice
        x=zeros(height,1);
        for i=1:height
            x(i)=mean(find(lineimage(i,:)));
        end
        y=(1:height)';
    else
        % Find middle of line for each vertical slice
        y=zeros(width,1);
        for j=1:width
            y(j)=mean(find(lineimage(:,j)));
        end
        x=(1:width)';
    end

    % Scale y and x values by reference to image bounds
    y=y-1+ymin;
    y=y/height*ymax;
    x=x-1+xmin;
    x=x/width*xmax;

end



