% genwave.m 
% simple wave generation
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% waveform parameters
dt = 0.01;
tmax = 2;
t = 0:dt:tmax;
f = 2;

% generate the signal
x = 1*sin(2*pi*f*t);
plot(t,x);

% calculate the signal's RMS value
sqrt((sum(x.*x)*dt)/tmax)

% it is a known factor
1/sqrt(2)
%---------------------------------------------------------------
