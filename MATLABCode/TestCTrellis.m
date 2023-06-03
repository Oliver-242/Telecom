% TestCTrellis.m
% test the convolutional code trellis
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
clear classes

NumStates = 4;
MaxTimeIdx = 7;
NumStateBits = 2;
NumOutBits = 3;

hTrellis = CTrellis(NumStates, MaxTimeIdx, NumStateBits, NumOutBits);
hTrellis.PopulateNodes();

BitSeq = '110010';
[CodeSeq] = hTrellis.EmitCodewordSeq(BitSeq);

% this is the transmitted code sequence
CodeSeq

% to insert an error in transmission
%CodeSeq(2,:) = '111';

% the receiver performs the following processing
hTrellis.ForwardPass(CodeSeq);
hTrellis.ShowPathCosts();

[StateSeq, BitSeq, CodeSeq] = hTrellis.Backtrack();
StateSeq
BitSeq
CodeSeq
%---------------------------------------------------------------
