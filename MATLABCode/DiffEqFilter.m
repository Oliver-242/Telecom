% DiffEqFilter.m 
% difference equations using filter function 
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% Transfer function Y(z)/X(z) has numerator b and denominator a.
% Take care when transferring these to a difference equation:
%  a(1) = 1 always, and a(2:end) is the negative of the 
% difference equation coefficients.
%---------------------------------------------------------------

%---------------------------------------------------------------
b = [0 0.8];
a = [1 -1.5 0.64];

% impulse input
x = zeros(25, 1);
x(1) = 1;

% Compute the sequence of output samples in y, 
% corresponding to each input in x.
% The coefficients in b and a define the z transform coefficients.
% Equivalently, these are the difference equation coefficients, 
% but see note above. 
y = filter(b, a, x);

stem(y);
%---------------------------------------------------------------
