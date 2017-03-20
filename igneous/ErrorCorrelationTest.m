

% Generate test dataset
nSamplesPerStep = 100;
nSteps = 7;

testdata = [];
testage = [];
for i = 1:nSteps
%     testdata = [testdata; 10.^(randn(1000,1)/10+log10(i))]; % Arbitrary data units.
    testdata = [testdata; randn(nSamplesPerStep,1)/2+(i)]; % Normal distribution of data, arbitrary data units.
    testage = [testage; ones(nSamplesPerStep,1).*i]; % Arbitrary age units
end
ageuncert = ones(size(testage))/2; % Two-sigma uncertaintes of one age unit
n = testage; % Group number

figure; plot(testage, testdata,'.')
hold on; plot([0 nSteps+1],[0 nSteps+1]);
xlim([0 nSteps+1]); ylim([0 nSteps+1]);
xlabel('Age (arbitrary units)'); ylabel('Composition (arbitrary units)');
formatfigure;

%% Resample with uncorrelated uncertainties of +/- 1 unit (2-sigma)

nResamplings = 10000;
resampledData = repmat(testdata,1,nResamplings); % One row per sample, one column per resampling
resampledAge = repmat(testdata,1,nResamplings) + repmat(ageuncert,1,nResamplings).*randn(length(ageuncert),nResamplings); % One row per sample, one column per resampling

% Plot first 4 resamplings
figure; subplot(1,4,1)
for i=1:4
    subplot(1,4,i); plot(resampledAge(:,i),resampledData(:,i),'.')
    xlim([0 nSteps+1]); ylim([0 nSteps+1]);
    formatfigure;
end

% Plot resampled mean
figure; binplot(resampledAge(:),resampledData(:),0,nSteps+1,nResamplings,20,'.')
xlim([0 nSteps+1]); ylim([0 nSteps+1]);
xlabel('Age (arbitrary units)'); ylabel('Composition (arbitrary units)');
formatfigure;

%% Resample with coorelated uncertainties of +/- 1 unit (2-sigma)

nResamplings = 10000;
resampledData = repmat(testdata,1,nResamplings); % One row per sample, one column per resampling
resampledAge = NaN(length(testdata),nResamplings); % One row per sample, one column per resampling
for i=1:nSteps 
    % Fill in age uncertainty for each "step" in age, step-by-step
    resampledAge(n==i,:) = repmat(testage(n==i),1,nResamplings) + repmat(ageuncert(n==i),1,nResamplings).*repmat(randn(1,nResamplings),nSamplesPerStep,1);
end



% Plot first 4 resamplings
figure; subplot(1,4,1)
for i=1:4
    subplot(1,4,i); plot(resampledAge(:,i),resampledData(:,i),'.')
    xlim([0 nSteps+1]); ylim([0 nSteps+1]);
    formatfigure;
end

% Plot resampled mean
figure; binplot(resampledAge(:),resampledData(:),0,nSteps+1,nResamplings,20,'.')
xlim([0 nSteps+1]); ylim([0 nSteps+1]);
xlabel('Age (arbitrary units)'); ylabel('Composition (arbitrary units)');
formatfigure;