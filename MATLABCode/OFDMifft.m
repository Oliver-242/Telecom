% OFDMifft.m 
% OFDM using IFFT
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
N = 64;
X = zeros(N, 1);

% subcarrier number, start at 1 up to N/2
k = 3;

% amplitude of this subcarrier
A = 1;

% start at component index 1 (2 in MATLAB)
% scale amplitude by N/2
% complementary component has to be complex conjugate
% -1j for sine, +1 for cosine

X(k+1) = -1j*N/2*A;	% choose for sine (Q)
X(k+1) = N/2*A;		% choose for cosine (I)

X(N-k+1) = conj(X(k+1));

x = ifft(X);

% xr should be zero, but may have small imaginary
% components due to arithmetic rounding
xr = real(x);

stem(x);
%---------------------------------------------------------------
