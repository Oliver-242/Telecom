% FMTheory.m
% motivate development of FM theory
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
N = 1000;
beta = 10;

n = 2;
taum = 1;
wm = 2*pi/taum;
wc = 10*wm;

t = linspace(0, taum, N);
dt = t(2) - t(1);
%---------------------------------------------------------------

%---------------------------------------------------------------
% the FM signal 
xfm = cos(wc*t + beta*sin(wm*t));

figure(1);
plot(t, xfm);
title('FM Waveform');

% the modulation 
xm = cos(wm*t);

% carrier signal, 
% carrier plus modulation frequency, 
% carrier plus twice modulation frequency
xc = cos(wc*t);
xh1 = cos(wc*t + wm*t);
xh2 = cos(wc*t + 2*wm*t);
%---------------------------------------------------------------

%---------------------------------------------------------------
Integral11 = dt*sum(xh1.*xh1);
Integral12 = dt*sum(xh1.*xh2);

Integral21 = dt*sum(xh2.*xh1);
Integral22 = dt*sum(xh2.*xh2);

fprintf(1, 'Product-Integral terms:\n');
fprintf(1, 'Int 11 = %f    Int 12 = %f    Int 21 = %f     Int 22 = %f\n', ...
    Integral11, Integral21, Integral21, Integral22);
%---------------------------------------------------------------

%---------------------------------------------------------------
fprintf(1, 'FM Expansion terms:\n');
term1 = cos(2*wc*t + beta*sin(wm*t) + wm*t);
term2 = cos(beta*sin(wm*t) - n*wm*t);
IntegralTerm1 = dt*sum(term1);
IntegralTerm2 = dt*sum(term2);
fprintf(1, 'Term 1 = %f  Term 2 = %f\n', IntegralTerm1, IntegralTerm2);
%---------------------------------------------------------------

%---------------------------------------------------------------
% compare to Bessel function 
% J_n(beta)
t = linspace(0, pi, N);
dt = t(2) - t(1);
Jarg = cos(beta*sin(t) - n*t);
Jcalc = (1/pi)*sum(Jarg*dt);
%plot(t, Jarg)

JMatlab = besselj(n, beta);
disp('Compare Bessel evaluations');
fprintf(1, 'Calculated %f, MATLAB built-in %f\n', Jcalc, JMatlab)
%---------------------------------------------------------------
