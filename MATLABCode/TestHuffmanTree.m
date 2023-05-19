% TestHuffmanTree.m 
% test Huffman tree class
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
Syms = ['A' 'B' 'C' 'D' 'E'];
Probs = [0.3 0.25 0.20 0.18 0.07];

hTree = HuffmanTree(Syms, Probs);
%---------------------------------------------------------------

%---------------------------------------------------------------
Sym = 'A';
BitStr = hTree.Ascend(Sym);
fprintf(1, 'Symbol "%s" encoded as bit string "%s"\n', Sym, BitStr);

% reverse order
TransBitStr = fliplr(BitStr);

BitStr = '101';
DecSym = hTree.Descend(BitStr);
fprintf(1, 'Bit string "%s" decodes to symbol "%s"\n', BitStr, DecSym);
%---------------------------------------------------------------
