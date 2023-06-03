% sincplot.m 
% plot a sinc function
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
N = 1024*4;
Tmax = 10;

% note using 'negative' time here
dt = Tmax/((N-1)/2);
t = -Tmax:dt:Tmax;

% time of zero crossing
tau = 0.4;

% sinc
hsinc = sin(pi*t/tau + eps)./(pi*t/tau + eps);
plot(t, hsinc);
xlabel('time');
ylabel('amplitude');
%---------------------------------------------------------------
