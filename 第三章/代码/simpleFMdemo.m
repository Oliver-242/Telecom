% SimpleFMDemod.m 
% simple example of FM demodulation
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% waveform parameters
N = 2000;
Tmax = 20;
dt = Tmax/(N-1);
t = 0:dt:Tmax;
fs = 1/dt;

% carrier
fc = 3;
wc = 2*pi*fc;
xc = cos(wc*t);

% modulating signal
fm = 0.2;
wm = 2*pi*fm;
Am = 1;
xm = Am*cos(wm*t);

% FM modulation parameters
A = 2;
kf = 10;

% integral of xm
xmi = cumsum(xm)*dt;

% combine with carrier to produce FM
xfm = A*cos(wc*t + kf*xmi);

% first stage of FM demodulation - differentiation to produce AM
dxfm = diff(xfm)/dt;

% plot the signals
subplot(4,1,1); 
plot(xm);

subplot(4,1,2); 
plot(xc);

subplot(4,1,3); 
plot(xfm);

subplot(4,1,4); 
plot(dxfm);
%---------------------------------------------------------------