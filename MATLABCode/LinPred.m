% LinPred.m
% linear prediction
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
N = 200;

% poles at radius r & angle omega
r = 0.9;
omega = pi/10;
p = r*exp(j*omega);

a = poly([p conj(p)]);
roots(a)

% system input
e = 0.05*randn(N, 1);

% response to input
x = filter(1, a, e);

% calculate autocorrelations
R0 = sum(x .* x)/N;
R1 = sum(x(1:N-1) .* x(2:N))/(N);
R2 = sum(x(1:N-2) .* x(3:N))/(N);

% autocorrelation matrix & vector
R = [R0 R1 ; R1 R0 ];
r = [R1 ; R2];

% optimal predictor solution
a = inv(R)*r;

% optimal predictor parameters as a filter
am = [1 ; -a];

% estimated output
xhat = filter(1, am, e);
%---------------------------------------------------------------

%---------------------------------------------------------------
figure(1);

subplot(3,1,1);
plot(x);
title('Signal x(n)');

subplot(3,1,2);
plot(xhat);
title('Estimate of x(n)');

subplot(3,1,3);
plot(e);
title('Excitation e(n)');
%---------------------------------------------------------------
