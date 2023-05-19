% AvCodeLen.m
% average codeword length
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% the symbol lengths in bits
s = [4 3 3 2];

% the probability of each symbol
pr = [0.5 0.2 0.2 0.1];

% check - sum of probabilities should be one
sum(pr)

% the average codeword length
sum(pr.*s)
%---------------------------------------------------------------
