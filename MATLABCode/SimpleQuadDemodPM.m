% SimpleQuadDemodPM.m 
% Quadrature demodulation of PM
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

% PM modulation
fm = 0.2;
wm = 2*pi*fm;
Am = 1;
xm = Am*sin(wm*t);

kp = 10;
A = 2;
% phase modulation equation
xpm = A*cos(wc*t + kp*xm);

% PM Demodulation
theta = pi/3;
xc = cos(wc*t + theta);
xs = sin(wc*t + theta);

I = xpm.*xc;
Q = xpm.*xs;
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
plot(xpm);
title('Phase Modulated');

subplot(4,1,4);
plot(xd);
title('Recovered');
%---------------------------------------------------------------
