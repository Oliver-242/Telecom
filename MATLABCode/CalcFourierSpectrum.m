% CalcFourierSpectrum.m 
% calculate the Fourier spectrum of a time function
%---------------------------------------------------------------

%---------------------------------------------------------------
function [Xm, faxis, xtw] = CalcFourierSpectrum(xt, tmax, fmax, UseWindow)

    %---------------------------------------------------------------
    dt = tmax/(length(xt) - 1);
    t = 0:dt:tmax;
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    xtw = xt;
    if( UseWindow )
        % window
        fw = 1/(2*tmax);

        % Hamming window
        fw = 1/(tmax);
        w = 0.54 - 0.46*cos(2*pi*t/tmax);
        xtw = xt.*w;
    end

    % continuous frequency range
    OmegaMax = 2*pi*fmax;
    dOmega = OmegaMax*.001;
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    fvec = [];
    Xmvals = [];

    p = 1;
    for Omega = 0:dOmega:OmegaMax

        coswave = cos(Omega*t);
        sinwave = -sin(Omega*t);

        % perform the Fourier Transform via numerical integration
        Xreal = sum(xtw.*coswave*dt);
        Ximag = sum(xtw.*sinwave*dt);
        mag = sqrt(Xreal*Xreal + Ximag*Ximag);

        % scale freqency to Hz, magnitude to maximum time
        fHz = Omega/(2*pi);
        mag = 2*mag/tmax;

        % save frequency and magnitude
        faxis(p) = fHz;
        Xm(p) = mag;
        p = p + 1;
    end
    %---------------------------------------------------------------
end
%---------------------------------------------------------------
