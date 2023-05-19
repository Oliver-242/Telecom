% HuffmanTree.m
% Huffman code tree class
%---------------------------------------------------------------

%---------------------------------------------------------------
classdef HuffmanTree < handle
    %---------------------------------------------------------------
    properties (SetAccess = private)
        % the root node itself
        hRootNode

        % list of all the nodes
        hAllNodes
    end
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    methods
        % constructor
        function hTree =  HuffmanTree(Syms, Probs)
            hRootNode = hTree.CreateTree(Syms, Probs);
        end

        %----------------------------------------------------------------
        % add tree methods here
        %----------------------------------------------------------------

        %----------------------------------------------------------------
        function hRootNode =  CreateTree(hTree, Syms, Probs)
            
            %----------------------------------------------------------------
            % create leaf nodes
            Paired = []; % zeros(N, 1);
            N = length(Syms);
            for n = 1:N
                IsRoot = false;
                IsLeaf = true;
                hNewNode = HuffmanNode(IsRoot, IsLeaf, Syms(n), Probs(n));
                hTree.hAllNodes = [hTree.hAllNodes hNewNode];
                Paired = [Paired false];
            end
            %----------------------------------------------------------------

            %----------------------------------------------------------------
            % combine nodes in pairs. There are N-1 pairing nodes
            for n = 1:N-1

                PairList = [];
                for k = 1:length(hTree.hAllNodes)
                    if( ~Paired(k) )
                        % candidate for pairing
                        PairList = [PairList k];
                    end
                end

                % Just select the first two.
                % Does not preserve the sibling ordering, and so
                % is not guaranteed to generate the shortest possible
                % codewords.
                iup = PairList(1);
                idown = PairList(2);

                % A better method: sort in order of increasing
                % probabilities, and then select the two lowest
                % for combining.
                ProbVals = [];
                for p = 1:length(PairList)
                    i = PairList(p);
                    ProbVals = [ProbVals hTree.hAllNodes(i).Prob];
                end

                % sort all node probabilities in ascending order
                % return the index of the ordering
                [SortedVals, SortIdx] = sort(ProbVals);

                % From the pair list, need to select those two with
                % the lowest probability. This is the first two
                % of the sort index list.
                iup = PairList(SortIdx(2));
                idown = PairList(SortIdx(1));

                % flag as having been combined
                Paired(iup) = true;
                Paired(idown) = true;

                fprintf(1, 'selected up : %d, sym:"%s" prob:%f\n', ...
                  iup, hTree.hAllNodes(iup).Sym, hTree.hAllNodes(iup).Prob);
                fprintf(1, 'selected down: %d, sym:"%s" prob:%f\n', ...
                  idown, hTree.hAllNodes(idown).Sym, hTree.hAllNodes(idown).Prob);

                % create parent node with sum of probabilities
                ProbSum = hTree.hAllNodes(iup).Prob + hTree.hAllNodes(idown).Prob;

                % create a fake node name by combining the child node names
                NodeSym = [hTree.hAllNodes(iup).Sym  hTree.hAllNodes(idown).Sym];

                IsRoot = false;
                IsLeaf = false;

                hNewNode = HuffmanNode(IsRoot, IsLeaf, NodeSym, ProbSum, ...
                                        hTree.hAllNodes(iup), ...
                                        hTree.hAllNodes(idown));

                % child nodes point to parent
                hTree.hAllNodes(iup).hParent = hNewNode;
                hTree.hAllNodes(iup).BitValue = '1';

                % parent node up & down point to children
                hTree.hAllNodes(idown).hParent = hNewNode;
                hTree.hAllNodes(idown).BitValue = '0';

                fprintf(1, 'created new node with prob %f\n', ProbSum);
                fprintf(1, 'Parent is: \n');
                disp(hNewNode);

                % save new parent in list of all nodes; not paired yet
                hTree.hAllNodes = [hTree.hAllNodes  hNewNode];
                Paired = [Paired false];

                if( n == N-1 )
                    % this occurs only when the very last pair is
                    % combined, which by definition is the root node
                    hNewNode.IsRoot = true;
                    hRootNode = hNewNode;
                    fprintf(1, 'Root node saved\n');

                    hRootNode.disp();
                end
               %----------------------------------------------------------------
            end
            %----------------------------------------------------------------
            
            %----------------------------------------------------------------
            % save root node in tree structure itself
            hTree.hRootNode = hRootNode; 
            %----------------------------------------------------------------
        end
       %----------------------------------------------------------------

       %----------------------------------------------------------------
       function [DecSym] = Descend(hTree, BitStr)
           BitsGiven = length(BitStr);
           hCurrNode = hTree.hRootNode;

           BitsUsed = 0;
           while( ~hCurrNode.IsLeaf )
               BitsUsed = BitsUsed + 1;
               if( BitsUsed > length(BitStr) )
                   % decoded symbol
                   DecSym = [];

                   fprintf(1, 'Descend(): not enough bits\n');
                   return;
               end

               CurrBit = BitStr(BitsUsed);
               fprintf(1, 'Currbit %c\n', CurrBit);
               if( CurrBit == '1' )
                   % up
                   hCurrNode = hCurrNode.hUp;
               else
                   hCurrNode = hCurrNode.hDown;
               end
               disp(hCurrNode);
           end
           fprintf(1, 'At Leaf, symbol "%s"  bits used=%d (given %d)\n', ...
                hCurrNode.Sym, BitsUsed, BitsGiven);

           if( BitsUsed == BitsGiven )
               DecSym = hCurrNode.Sym;
           else
               DecSym = [];
               fprintf(1, 'Error: bits used %d, bits given %d\n', ...
                    BitsUsed, BitsGiven);
           end
       end
       %----------------------------------------------------------------

       %----------------------------------------------------------------
       function [BitStr] = Ascend(hTree, Sym)
           % find starting node in list of leaf nodes
           NumNodes = length(hTree.hAllNodes);
           fprintf(1, 'Searching %d leaf nodes\n', NumNodes);
           StartLeaf = 0;
           for n = 1:NumNodes
               if( hTree.hAllNodes(n).IsLeaf )
                   if( hTree.hAllNodes(n).Sym == Sym )
                       StartLeaf = n;
                       break;
                   end
               end
           end

           if( StartLeaf == 0 )
               fprintf(1, 'Ascend() error: cannot find symbol in nodes\n');

               % signals error
               BitStr = [];
               return;
           end

           % starting leaf node for the given symbol
           hCurrNode = hTree.hAllNodes(StartLeaf);

           % accumulated bit string from leaf to root
           BitStr = [];

           while( ~isempty(hCurrNode) )
               disp(hCurrNode);

               if( ~hCurrNode.IsRoot )
                   % accumulate bits along the way
                   BitStr = [BitStr  hCurrNode.BitValue];
               end

               hCurrNode = hCurrNode.hParent;
           end
        end
        %----------------------------------------------------------------

    %---------------------------------------------------------------
    end  % end methods
    %----------------------------------------------------------------
end
%---------------------------------------------------------------
