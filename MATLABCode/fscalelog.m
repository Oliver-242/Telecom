% fscalelog.m 
% frequency response - logarithmic
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
r = -2:0.04:2;
f = 10.^r;
g = 1./(f + 1);
plot(f, g, 's-');
set(gca, 'xscale', 'log');
grid('on');
%---------------------------------------------------------------
