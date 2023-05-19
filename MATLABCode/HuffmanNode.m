% HuffmanNode.m
% Huffman code node class
%---------------------------------------------------------------

%---------------------------------------------------------------
% Huffman node class. Returns a handle (pointer) to the data structure
classdef HuffmanNode < handle
    %---------------------------------------------------------------
    properties (SetAccess = private)
        Sym         % symbol for this node
        Prob        % probability of this symbol
    end
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    properties
        IsRoot       % the root node
        IsLeaf       % leaf or branch node
        hUp          % up pointer, branch if 1
        hDown        % down pointer, branch if 0
        hParent      % parent node
        BitValue     % 1=up, higher prob, 0=down, lower prob
    end
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    methods
      function hNode =  HuffmanNode(IsRoot, IsLeaf, Sym, Prob, hUp, hDown)

          hNode.IsRoot = IsRoot;
          hNode.IsLeaf = IsLeaf;
          hNode.Sym = Sym;
          hNode.Prob = Prob;

          if( nargin == 4 )
              hUp = HuffmanNode.empty;  % up & down pointers not given,
              hDown = HuffmanNode.empty; % so initialize to empty
          end
          hNode.hUp = hUp;
          hNode.hDown = hDown;
          hNode.hParent = HuffmanNode.empty;
          hNode.BitValue = '-';
      end
    end
    %---------------------------------------------------------------
end
%---------------------------------------------------------------
