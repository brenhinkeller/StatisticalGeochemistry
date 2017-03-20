function melts=rmelts(sc,elems,varargin)
% Run alphaMELTS script

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Default Settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MELTS or pMELTS
version='pMELTS';
%Mode (isothermal, isobaric, isentropic, isenthalpic, isochoric, geothermal or PTPath)
mode='isobaric';
% Set fO2 constraint, i.e. 'IW','COH','FMQ','NNO','HM','None' as a string
fo2path='FMQ';
% Ouptut temperatures in celcius? ('!' for no, '' for yes)
celciusoutput='';
% Save all output? ('!' for no, '' for yes)
saveall='!';
% Batch file string
batchstring='0\n';
% Fractionate all solids? ('!' for no, '' for yes)
fractionatesolids='!';
% Mass retained during fractionation
massin=0.001;
% Fractionate all water? ('!' for no, '' for yes)
fractionatewater='!';
% Fractionate individual phases (specify as strings in cell array, i.e. {'olivine','spinel'})
fractionate={};
% Supress individual phases (specify as strings in cell array, i.e. {'leucite'})
supress={};
% Coninuous (fractional) melting? ('!' for no, '' for yes)
continuous='!';
% Threshold above which melt is extracted (if fractionation is turned on)
minf=0.005;
% Do trace element calculations
dotrace='!';
% Treat water as a trace element
dotraceh2o='!';
% Initial trace compositionT
tsc=[];
% Initial trace elements
telems='';
% Default global constraints
Pmax=90000;
Pmin=2;
Tmax=3000;
Tmin=450;
% Set temperature and pressure increments (positive increments if you want
% T or P to increase each step, negative if you want it to decrease, 0 for
% constant T or P)
dT=0;
dP=0;
% Set initial T and P
Ti=1700;
Pi=7000;
% Simulation number (for folder, etc)
simnumber=1;
% Break up the output into individual variables?
elementout=1;

%%%%%%%%%%%%%%%%%%%%%%%%%% end Default Settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% User settings from varargin
for i=1:length(varargin)/2
      eval(sprintf('%s=varargin{2*i};',varargin{2*i-1}))
end

% Interpret provided settings
% if  all(fo2path=='QFM'); fo2path='FMQ';
if ~exist('Tf','var'); Tf=Ti; end
if ~exist('Pf','var'); Pf=Pi; end

% Guess if intention is for calculation to end at Tf or Pf as a min or max
if Tf<Ti; Tmin=Tf; end;
if Tf>Ti; Tmax=Tf; end;
if Pf<Pi; Pmin=Pf; end;
if Pf>Pi; Pmax=Pf; end;

% Read user settings again to allow user to override P & T min, max
for i=1:length(varargin)/2
      eval(sprintf('%s=varargin{2*i};',varargin{2*i-1}))
end

sc=sc./sum(sc).*100; % Normalize starting composition

% Initialize output variable
melts=struct;

% output workdirectory name
workdir=['out' num2str(simnumber)];
[~,~]=unix(['rm -rf' workdir]); % Ensure directory is empty
[~,~]=unix(['mkdir -p ' workdir]);

% Make .melts file containing the starting composition you want to run
% simulations on
fid=fopen([workdir '/sc.melts'],'w');
for i=1:length(elems)
    fprintf(fid,'Initial Composition: %s %.4f\n',elems{i},sc(i));
end
for i=1:length(telems)
    fprintf(fid,'Initial Trace: %s %.4f\n',telems{i},tsc(i));
end

fprintf(fid,'Initial Temperature: %.2f\nInitial Pressure: %.2f\nlog fo2 Path: %s\n',...
    Ti,Pi,fo2path);
for i=1:length(fractionate); fprintf(fid,'Fractionate: %s\n',fractionate{i}); end
for i=1:length(supress); fprintf(fid,'Suppress: %s\n',supress{i}); end
fclose(fid);

% Make melts_env file to specify type of MELTS calculation
fid=fopen([workdir '/melts_env.txt'],'w');
fprintf(fid,['! *************************************\n!  MATLAB-generated environment file\n! *************************************\n\n'...
    '! this variable chooses MELTS or pMELTS; for low-pressure use MELTS\nALPHAMELTS_VERSION		%s\n\n'...
    '! do not use this unless fO2 anomalies at the solidus are a problem\n!ALPHAMELTS_ALTERNATIVE_FO2	true\n\n'...
    '! use this if you want to buffer fO2 for isentropic, isenthalpic or isochoric mode\n! e.g. if you are doing isenthalpic AFC\n!ALPHAMELTS_IMPOSE_FO2		true\n\n'...
    '! use if you want assimilation and fractional crystallization (AFC)\n!ALPHAMELTS_ASSIMILATE		true\n\n'...
    '! isothermal, isobaric, isentropic, isenthalpic, isochoric, geothermal or PTPath\nALPHAMELTS_MODE			%s\n!ALPHAMELTS_PTPATH_FILE		ptpath.txt\n\n'...
    '! need to set DELTAP for polybaric paths; DELTAT for isobaric paths\nALPHAMELTS_DELTAP	%.0f\nALPHAMELTS_DELTAT	%.0f\nALPHAMELTS_MAXP		%.0f\nALPHAMELTS_MINP		%.0f\nALPHAMELTS_MAXT		%.0f\nALPHAMELTS_MINT		%.0f\n\n'...
    '! this one turns on fractional crystallization for all solids\n! use Fractionate: in the melts file instead for selective fractionation\n%sALPHAMELTS_FRACTIONATE_SOLIDS	true\n%sALPHAMELTS_MASSIN		%g\n\n'...
    '! free water is unlikely but can be extracted\n%sALPHAMELTS_FRACTIONATE_WATER	true\n%sALPHAMELTS_MINW			0.005\n\n'...
    '! the next one gives an output file that is always updated, even for single calculations\n%sALPHAMELTS_SAVE_ALL		true\n!ALPHAMELTS_SKIP_FAILURE		true\n\n'...
    '! this option converts the output temperature to celcius, like the input\n%sALPHAMELTS_CELSIUS_OUTPUT	true\n\n'...
    '! the next two turn on and off fractional melting\n%sALPHAMELTS_CONTINUOUS_MELTING	true\n%sALPHAMELTS_MINF			%g\n%sALPHAMELTS_INTEGRATE_FILE	integrate.txt\n\n'...
    '! the next two options refer to the trace element engine\n%sALPHAMELTS_DO_TRACE		true\n%sALPHAMELTS_DO_TRACE_H2O		true\n'],...
    version,mode,dP,dT,Pmax,Pmin,Tmax,Tmin,fractionatesolids,fractionatesolids,massin,fractionatewater,fractionatewater,saveall,celciusoutput,continuous,continuous,minf,continuous,dotrace,dotraceh2o);
fclose(fid);

% Make a batch file to run the above .melts file starting from the liquidus
fid=fopen([workdir '/batch.txt'],'w');
eval(['fprintf(fid,''' batchstring ''');'])
fclose(fid);

% Run the command
% Edit the following line(s to make sure you have a correct path to the 'run_alphamelts.command' perl script
[~,~]=unix(['cd ' workdir '; /usr/local/bin/run_alphamelts.command -f melts_env.txt -b batch.txt']);

    
% Import the results
if exist([workdir '/Phase_main_tbl.txt'],'file')
    cells=importc([workdir '/Phase_main_tbl.txt'],' ');
    emptycols=all(cellfun('isempty', cells),1);
    cells=cells(:,~emptycols);
    pos=[find(all(cellfun('isempty', cells),2)); size(cells,1)+1];
    melts.minerals=cell(length(pos)-1,1);
    for i=1:(length(pos)-1)
        name=varname(cells(pos(i)+1,1));
        melts.(name{1}).elements=varname(cells(pos(i)+2,~cellfun('isempty',cells(pos(i)+2,:))));
        melts.(name{1}).data=str2double(cells(pos(i)+3:pos(i+1)-1,1:length(melts.(name{1}).elements)));
        if elementout; melts.(name{1})=elementify(melts.(name{1})); end
        melts.minerals(i)=name;
    end
else
    melts=[];
end

end