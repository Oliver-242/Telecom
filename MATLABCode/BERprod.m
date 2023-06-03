% BERprod.m
% product of individual blocks and bit error rate
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
ber = [1/100 1/1000 1/10000];
bertotal = 1 - prod(1-ber)
%---------------------------------------------------------------
