% BesselExamp.m
% Bessel function examples
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
n = 3;
beta = 5;
besselj(n, beta)

n = -6:6;
beta = 2.5;
bc = besselj(n, beta)

sum(bc.^2)
%---------------------------------------------------------------