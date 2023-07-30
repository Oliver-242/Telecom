% SimpleQuadDemodFM.m 
% Quadrature demodulation of FM
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

% FM modulation
fm = 0.2;
wm = 2*pi*fm;
Am = 1;
xm = Am*cos(wm*t);

A = 2;
kf = 10;

% integral of xm
xmi = cumsum(xm)*dt;
% frequency modulation equation
xfm = A*cos(wc*t + kf*xmi);

% FM Demodulation
theta = pi/3;
xc = cos(wc*t + theta);
xs = sin(wc*t + theta);

I = xfm.*xc;
Q = xfm.*xs;

d = -1*atan2(Q, I);
xd = unwrap(d);
%---------------------------------------------------------------

%---------------------------------------------------------------
subplot(4,1,1);
plot(xm);
title('Modulation');

subplot(4,1,2);
plot(xc);
title('Carrier');

subplot(4,1,3);
plot(xfm);
title('Frequency Modulated');

subplot(4,1,4);
plot(xd);
title('Recovered');
%---------------------------------------------------------------