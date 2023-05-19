% CNode.m
% node class for convolutional coding
%---------------------------------------------------------------

%---------------------------------------------------------------
classdef CNode < handle

    properties
        StateIdx      % index of this node's state
        TimeIdx       % time index of this node

        NextStateIdx  % index of next node
        Bit           % input bit for transition
        Code          % output code for transition
        PrevStateIdx  % index of previous state

        PathCost     % cumulative path cost
        PathIdx      % best backtrack path index
    end

    methods  (Access = public)
        function [hNode] =  CNode(StateIdx, TimeIdx)
            hNode.StateIdx = double.empty;
            hNode.TimeIdx = double.empty;
            hNode.NextStateIdx = double.empty;
            hNode.PrevStateIdx = double.empty;
            hNode.Bit = char.empty;
            hNode.Code = char.empty;

            hNode.PathCost = inf;
            hNode.PathIdx = 0;

            if( nargin == 2 )
                hNode.StateIdx = StateIdx;
                hNode.TimeIdx = TimeIdx;
            end
        end

        function SetNext(hNode, Idx, StateIdx, Bit, Code)
            hNode.NextStateIdx(Idx) = StateIdx;
            hNode.Bit(Idx) = Bit;
            hNode.Code(Idx, :) = Code;
        end

        function ClearNext(hNode)
            hNode.NextStateIdx = double.empty;
            hNode.Bit = char.empty;
            hNode.Code = char.empty;
        end

        function AddPrev(hNode, StateIdx)
            hNode.PrevStateIdx = [hNode.PrevStateIdx StateIdx];
        end

        function ClearPrev(hNode)
            hNode.PrevStateIdx = double.empty;
        end
    end % end methods
end
%---------------------------------------------------------------
