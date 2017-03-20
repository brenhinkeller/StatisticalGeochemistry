function map(lat,lon,varargin)
% MAP(lat,lon,['etopo','tc1','hold on', style])
% Plot an image of the earth with points at the coordinates specified by 
% lat, lon. Style options (e.g., '.r') are passed directly to PLOT(). 

% Check for input flags
    etp = false;
    tc1 = false;
    medium = false;
    hldon = false;
    if nargin>2
        hldon=strcmp(varargin,'hold on');
        etp=strcmp(varargin,'etopo')|strcmp(varargin,'large');
        medium=strcmp(varargin,'medium');
        tc1=strcmp(varargin,'tc1');
    end
    
% Check for plot style options
    if nargin>2+sum(etp|hldon|medium|tc1)
        style = varargin(~(etp|hldon|medium|tc1));
    elseif any(etp)
        style={'.w'};
    else
        style={'.y'};
    end

% Find the current screen size
    pixss = get(0,'screensize');
    screenwidth = pixss(3)-24;
    
    
% Make the map.
    % If 'hold on' flag is specified, plot on top of preexisting figure
    if any(hldon);
        if any(etp)
            hold on; plot((lon+180)*60,(90-lat)*60,style{:});
        else
            hold on; plot((lon+180)*128/45,(90-lat)*128/45,style{:});
        end

    % Otherwise, pick a base image to show
    elseif any(etp)
        % Global topography image from ETOPO
        A=imread('world21600.jpg'); 
        imshow(A); hold on;
        plot((lon+180)*60,(90-lat)*60,style{:}) % Scale factor: 21600/360 = 60;
        set(gca,'position',[0 0 1 1],'units','normalized') % Remove border
        truesize([screenwidth/2,screenwidth]) % Attempt to show at full screen width


    elseif any(medium)
        % Equirectangular projection of 'blue marble' image
        A=imread('world5400.jpg'); 
        imshow(A); hold on;
        plot((lon+180)*15,(90-lat)*15,style{:}) % Scale factor: 5400/360 = 15;
        set(gca,'position',[0 0 1 1],'units','normalized') % Remove border  
        truesize([screenwidth/2,screenwidth]) % Attempt to show at full screen width


    else
        if any(tc1)
            % Lithospheric thickness model image
            A=imread('tc1lithosphere.png');
        else
            % World satellite-type image
            A=imread('world1024.jpg');
        end
        imshow(A); hold on;
        plot((lon+180)*128/45,(90-lat)*128/45,style{:}) % Scale factor: 1024/360 = 128/45;
        set(gca,'position',[0 0 1 1],'units','normalized') % Remove border
        truesize([512,1024]) % Show at 100% resolution
    end
end
