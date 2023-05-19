% PseudoNoise.m 
% Pseudo-Random Binary Sequence / Pseudo-Noise
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% number of samples in total
N = 4096;

% scale for 8 bit unsigned integer
S = 2^8 - 1;

% samples per bit
M = 256;

% number of bits
B = round(N/M);

% select either PRBS or PN
x = S*randi([0 1], [B, 1]); % PRBS - values 0 or 1
x = randi([0 S], [B, 1]);   % PN - values in range 0 to S-1

x = repmat(x', [M, 1]);
x = x(:);
xi = uint16(x);

plot(xi);
axis([0 N 0 S+1]);
title('Sampled Pseudo-Random Binary Sequence');
%---------------------------------------------------------------
