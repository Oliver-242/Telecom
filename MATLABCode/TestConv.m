% TestConv.m 
% test convolution of sequences
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
x = [1 2 3 4 5 6 7 8];
h = [10 11 12];

conv(x, h)

conv(h, x)
%---------------------------------------------------------------