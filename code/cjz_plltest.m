% PLLTest.m       
% Phase-Locked Loop (PLL) example for frequency change detection
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
N = 22000;       % total steps
M = 400;         % samples to average for lowpass filter

% phase angle step for simulation (radians per sample)
w = 2*pi/100;

% NCO frequency (phase step)
wosc = w;

% PLL loop parameters
K = 0.001;
calpha = 1;
cbeta = 0.001;      % faster to reach target, but overshoots
%cbeta = 0.0001;    % slower but does not overshoot

nw = 0;
nwsave = [];
nwosc = 0;
nwoscsave = [];

xMsave = [];

ph = 0;

ca = 0;
cb = 0;
cbprev = 0;

TestChangePhase = false;

% select phase or frequency change
TestChangeFreq = true;

% Frequency change parameters
freqChangeStep = 2000;  % Number of samples to change the frequency
freqChangeFactor = 0.98;  % Frequency change factor (0.98 means 2% frequency decrease)

for n = 1:N

    if TestChangePhase
        % phase change test
        if( n == 8000 )
           ph = 2;
    	end
    end

    if TestChangeFreq
        % frequency change test
        if( mod(n, freqChangeStep) == 0 )
            % effect change in frequency
            w = w * freqChangeFactor;
        end
    end

    xin(n) = sin(nw + ph);

    % oscillator waveforms - sine and cosine with calculated phase shift
    xsin(n) = sin(nwosc);
    xcos(n) = cos(nwosc);

    % averaging M samples for "lowpass" filtering of product of waveforms
    m = n:-1:n-M+1;
    m = m( m > 0 );

    yI = mean(xin(m).*xsin(m));
    yQ = mean(xin(m).*xcos(m));

    if( n < M )
        dw(n) = 0;
    else
        % phase estimator
        xM = atan2(yQ, yI);
        xMsave = [xMsave xM];

        % control algorithm
        ca = calpha*xM;
        cb = cbeta*xM + cbprev;
        yM = ca + cb;

        cbprev = cb;

        % final constant multiplier K
        dw(n) = K*yM;
    end

    nw = nw + w;
    nwosc = nwosc + wosc + dw(n);
end

figure(1);
subplot(2,1,1);
plot(dw);
axis('tight');
grid('minor');
title('Frequency change');

figure(1);
subplot(2,1,2);
plot(xMsave);
axis('tight');
grid('minor');
title('Control signal');
