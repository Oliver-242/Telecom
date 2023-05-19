% SimpleQuadDemodAM.m 
% uadrature demodulation of AM
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
N = 2000;
Tmax = 20;
dt = Tmax/(N-1);
t = 0:dt:Tmax;
fs = 1/dt;

% carrier
fc = 3;
wc = 2*pi*fc;
xc = cos(wc*t);

% modulation
fm = 0.2;
wm = 2*pi*fm;

xm = cos(wm*t);

Ac = 2;
mu = 0.2;
Am = mu*Ac;

% amplitude modulation equation
xam = Am*xm.*xc + Ac*xc;

% AM Demodulation - theta is arbitrary
theta = pi/3;
xc = cos(wc*t + theta);
xs = sin(wc*t + theta);

I = xam.*xc;
Q = xam.*xs;
xd = sqrt(I.^2 + Q.^2);
%---------------------------------------------------------------

%---------------------------------------------------------------
subplot(4,1,1);
plot(xm);
title('Modulation');

subplot(4,1,2);
plot(xc);
title('Carrier');

subplot(4,1,3);
plot(xam);
title('Amplitde Modulated');

subplot(4,1,4);
plot(xd);
title('Recovered');
%---------------------------------------------------------------
