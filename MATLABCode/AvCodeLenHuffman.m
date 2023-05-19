% AvCodeLenHuffman.m
% average codeword length using Huffman code sibling/no sibling
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% the probabilities
p = [0.30 0.25 0.20 0.18 0.07];

% codeword length, with and without sibling property maintained
nsib = [2 2 2 3 3];
nnosib = [1 2 3 4 4];

% average codeword length - sibling nodes combined
sum(p.*nsib)

% average codeword length - non-sibling nodes combined
sum(p.*nnosib)
%---------------------------------------------------------------
