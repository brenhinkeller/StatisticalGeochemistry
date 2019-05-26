function h = plotConcordiaEllipse(r206Pb_238U,r206Pb_238U_sigma,r207Pb_235U,r207Pb_235U_sigma,CorrCoeff,p,color)
% h = plotConcordiaEllipse(r206Pb_238U,r206Pb_238U_sigma,r207Pb_235U,r207Pb_235U_sigma,CorrCoeff,p,color)
% Calculate error ellipse semimajor and semiminor axes, and plot ellipse on 
% the current axis. 

    % Determine sigma level at which to plot
    sigmaLevel = sqrt(chi2inv(1-p,2)); % The bivariate (two degrees of freedom) sigma level corresponding to the p-value p

    % Allocate output variables
    a = NaN(size(r206Pb_238U));
    b = NaN(size(r206Pb_238U));
    theta = NaN(size(r206Pb_238U));
    
% Loop through each analysis
    for i=1:length(r206Pb_238U)
        % Construct covariance matrix from uncertainties and correlation coefficients
        covmat = [r206Pb_238U_sigma(i).^2, r206Pb_238U_sigma(i).*r207Pb_235U_sigma(i).*CorrCoeff(i);
            r206Pb_238U_sigma(i).*r207Pb_235U_sigma(i).*CorrCoeff(i), r207Pb_235U_sigma(i).^2];
        
        % For analysis with data
        if ~any(isnan(covmat))
            
            % Calculate eigenvectors and eigenvalues from the covariance matrix.
            % V: matrix of eigenvectors, D: diagonal matrix of eigenvalues
            [V,D] = eig(covmat);
            % Find index of major and minor axes
            [~,major] = max(diag(D));
            [~,minor] = min(diag(D));
            % Calculate length of semimajor and semiminor axes for given p-value
            a(i) = sigmaLevel*sqrt(abs(D(major,major)));
            b(i) = sigmaLevel*sqrt(abs(D(minor,minor)));
            % Larger (major) eigenvector
            v = V(:,major);
            % Calculate angle of ellipse from horizontal
            theta(i) = atan(v(2)/v(1));

        end
    end
    
    %Plot results
    npoints = 100;
    h=ellipse(b,a,-theta,r207Pb_235U,r206Pb_238U,color,npoints);
end        
