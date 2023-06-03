% StateTable.m
% defining the state table for a Viterbi encoder/decoder
%---------------------------------------------------------------

%---------------------------------------------------------------
% StateTable.m - state transition and codeword generation
classdef StateTable
    %---------------------------------------------------------------
    properties
        NumStates       % number of possible states
        NumStateBits    % bits for each state
        NumOutBits      % bits for each output
    end
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    methods (Access = public)
        function TheStateTable = ...
                     StateTable(NumStates, NumStateBits, NumOutBits)
            TheStateTable.NumStates = NumStates;
            TheStateTable.NumStateBits = NumStateBits;
            TheStateTable.NumOutBits = NumOutBits;
        end

        function ShowTable(TheStateTable)
            disp(TheStateTable);
        end
        
    end 
    %---------------------------------------------------------------


    %---------------------------------------------------------------
    % add other methods & helper functions here
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    methods (Access = public)
        % map state and input to output and next state
        function [Y, State, NextStateIndex, NextState] = ...
                        MapState(TheStateTable, StateIndex, x)

            % bitstring - LSB: highest index, MSB: lowest index
            State = TheStateTable.StateBits(StateIndex);
            Y = dec2bin(0, TheStateTable.NumOutBits);

            Y(3) = StateTable.xorstr([x]);
            Y(2) = StateTable.xorstr([x State(2)]);
            Y(1) = StateTable.xorstr([State(2) State(1)]);

            % next state = current state shifted left, input bit shifted into LSB
            NextState = [State(2:end) x];

            % convert binary string to actual index
            NextStateIndex = bin2dec(NextState)+1;
        end
    end
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    methods (Access = private)
        % Converts the current state (integer) into a character bitstring
        function str = StateBits(TheStateTable, StateIndex)
            str = dec2bin(StateIndex-1, TheStateTable.NumStateBits);
        end
    end
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    methods (Static)
        % multi-bit XOR, which is true if an odd number of 1's
        function resbit = xorstr(str)
            isodd = false;
            if( mod(length(find(str == '1')), 2) == 1 )
                isodd = true;
            end

            resbit = '0';
            if( isodd )
                resbit = '1';
            end
        end

        function d = HammingDist(x, y)
            d = length(find(x ~= y));
        end
    end
    %---------------------------------------------------------------
end
%---------------------------------------------------------------
