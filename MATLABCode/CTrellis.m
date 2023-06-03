% CTrellis.m
% class for trellis for convolutional coding
%---------------------------------------------------------------


%---------------------------------------------------------------
classdef CTrellis  < handle
    properties
        NumStates       % number of possible states
        MaxTimeIdx      % number of time intervals

        NumStateBits    % bits for each state
        NumOutBits      % bits for each output

        StateTable      % state mapping table
        hNodeTable      % array of all nodes, linked in a trellis
    end

    methods
        function [hTrellis] = CTrellis(NumStates, MaxTimeIdx, ...
                                NumStateBits, NumOutBits)

            % save dimensions of the trellis
            hTrellis.NumStates = NumStates;
            hTrellis.MaxTimeIdx = MaxTimeIdx;

            % save parameters of the trellis
            hTrellis.NumStateBits = NumStateBits;
            hTrellis.NumOutBits = NumOutBits;

            % create a state table for the trellis
            hTrellis.StateTable = StateTable(NumStates, NumStateBits, NumOutBits);

            % create pointers to initial state nodes
            hTrellis.hNodeTable = CNode();
            for TimeIdx = 1:hTrellis.MaxTimeIdx
                for StateIdx = 1:hTrellis.NumStates
                    hTrellis.hNodeTable(StateIdx, TimeIdx) = ...
               					CNode(StateIdx, TimeIdx);
                end
            end
        end

        %-----------------------------------------------------------
        % add other methods here:
        % PopulateNodes()
        % EmitCodewordSeq()
        % ForwardPass()
        % Backtrack()
        % ShowPathCosts()
        %-----------------------------------------------------------

        %-----------------------------------------------------------
        function PopulateNodes(hTrellis)
            % set branch transitions for each node in trellis
            for TimeIdx = 1:hTrellis.MaxTimeIdx
                for StateIdx = 1:hTrellis.NumStates

                    X = '01';
                    for k = 1:2
                        % current input bit
                        x = X(k);
                        [Y, State, NextStateIdx, NextState] = hTrellis.StateTable.MapState(StateIdx, x);

                        % forward pointer to state at next time index
                        if( TimeIdx == hTrellis.MaxTimeIdx )
                            hTrellis.hNodeTable(StateIdx, TimeIdx).ClearNext();
                        else
                            hTrellis.hNodeTable(StateIdx, TimeIdx).SetNext(k, NextStateIdx, x, Y);
                        end

                        % backwards pointer
                        if( TimeIdx == 1 )
                            hTrellis.hNodeTable(StateIdx, TimeIdx).ClearPrev();
                        end

                        if( TimeIdx < hTrellis.MaxTimeIdx )
                            hTrellis.hNodeTable(NextStateIdx, TimeIdx+1).AddPrev(StateIdx);
                        end
                    end
                end
            end
        end
        %-----------------------------------------------------------

        %-----------------------------------------------------------
        function [CodeSeq] = EmitCodewordSeq(hTrellis, BitSeq)
            BitSeqLen = length(BitSeq);
            TimeIdx = 1;
            StateIdx = 1;

            % returned digit sequence
            CodeSeq = char.empty;

            % traverse the list of nodes, forward direction
            for n = 1:BitSeqLen
                b = BitSeq(n);    % current bit

                % find this bit in forward table
                bits = { hTrellis.hNodeTable(StateIdx, TimeIdx).Bit };
                bits = char(bits);
                ibit = find(b == bits);

                Code = hTrellis.hNodeTable(StateIdx, TimeIdx).Code(ibit,:);
                CodeSeq(TimeIdx, :) = Code;

                % link to next node in trellis
                StateIdx = hTrellis.hNodeTable(StateIdx, TimeIdx).NextStateIdx(ibit);
                TimeIdx = TimeIdx + 1;
            end
        end
        %-----------------------------------------------------------

        %-----------------------------------------------------------
        function ForwardPass(hTrellis, CodewordSeq)
            NumDigits = length(CodewordSeq);

            % initialize path costs
            for TimeIdx = 1:hTrellis.MaxTimeIdx
                for StateIdx = 1:hTrellis.NumStates

                    if( TimeIdx == 1 )
                        hTrellis.hNodeTable(StateIdx, TimeIdx).PathCost = 0;
                        hTrellis.hNodeTable(StateIdx, TimeIdx).PathIdx = 0;
                    else
                        hTrellis.hNodeTable(StateIdx, TimeIdx).PathCost = Inf;
                        hTrellis.hNodeTable(StateIdx, TimeIdx).PathIdx = 0;
                    end
                end
            end

            for TimeIdx = 1:hTrellis.MaxTimeIdx-1

                RxCode = CodewordSeq(TimeIdx, :);
                for StateIdx = 1:hTrellis.NumStates
                    for k = 1:2

                        Code = hTrellis.hNodeTable(StateIdx, TimeIdx).Code(k,:);
                        Bit = hTrellis.hNodeTable(StateIdx, TimeIdx).Bit(k);

                        NextStateIdx = hTrellis.hNodeTable(StateIdx, TimeIdx).NextStateIdx(k);
                        HamDist = hTrellis.StateTable.HammingDist(RxCode, Code);

                        PathCost = hTrellis.hNodeTable(StateIdx, TimeIdx).PathCost;
                        NewCost = PathCost + HamDist;
                        CurrCost = hTrellis.hNodeTable(NextStateIdx, TimeIdx+1).PathCost;

                        if( NewCost < CurrCost )
                            hTrellis.hNodeTable(NextStateIdx, TimeIdx+1).PathCost = NewCost;
                            hTrellis.hNodeTable(NextStateIdx, TimeIdx+1).PathIdx = StateIdx;
                        end
                    end
                end
            end
        end
        %-----------------------------------------------------------


        %-----------------------------------------------------------
        function ShowPathCosts(hTrellis)
            for StateIdx = 1:hTrellis.NumStates
                for TimeIdx = 1:hTrellis.MaxTimeIdx
                    PathCost = hTrellis.hNodeTable(StateIdx, TimeIdx).PathCost;
                    PrevStateIdx = hTrellis.hNodeTable(StateIdx, TimeIdx).PathIdx;

                    fprintf(1, '%d / %d \t', PrevStateIdx, PathCost);
                end
                fprintf(1, '\n');
            end
        end
        %-----------------------------------------------------------

        %-----------------------------------------------------------
        function [StateSeq, BitSeq, CodeSeq] = Backtrack(hTrellis)
            RevStateSeq = zeros(1, hTrellis.MaxTimeIdx);
            CurrTimeIdx = hTrellis.MaxTimeIdx;

            TermCosts = cell2mat( { hTrellis.hNodeTable(:, CurrTimeIdx).PathCost } );
            [CurrCost, CurrStateIdx] = min(TermCosts);
            FwdTimeIdx = 1;

            while( CurrStateIdx > 0 )
                RevStateSeq(FwdTimeIdx) = CurrStateIdx;
                CurrCost = hTrellis.hNodeTable(CurrStateIdx, CurrTimeIdx).PathCost;
                fprintf(1, 'curr state/time %d/%d  cost %d\n', CurrStateIdx, CurrTimeIdx, CurrCost);

                NextStateIdx = hTrellis.hNodeTable(CurrStateIdx,CurrTimeIdx).PathIdx;
                CurrStateIdx = NextStateIdx;
                CurrTimeIdx = CurrTimeIdx - 1;
                FwdTimeIdx = FwdTimeIdx + 1;
            end

            % reverse the bit-string order 
            StateSeq = fliplr(RevStateSeq);
            BitSeq = char('x'*ones(1, hTrellis.MaxTimeIdx-1));
            CodeSeq = char('x'*ones(hTrellis.MaxTimeIdx-1, hTrellis.NumOutBits));

            for TimeIdx = 1:hTrellis.MaxTimeIdx-1
                StateIdx = StateSeq(TimeIdx);
                NextStateIdx = StateSeq(TimeIdx+1);

                % find this bit in forward table
                NextStates = hTrellis.hNodeTable(StateIdx, TimeIdx).NextStateIdx;
                istate = find(NextStateIdx == NextStates);
                Digits = hTrellis.hNodeTable(StateIdx, TimeIdx).Code(istate,:);
                DigitSeq(TimeIdx, :) = Digits;
                Bit = hTrellis.hNodeTable(StateIdx, TimeIdx).Bit(istate);
                BitSeq(TimeIdx) = Bit;

                Code = hTrellis.hNodeTable(StateIdx, TimeIdx).Code(istate, :);
                CodeSeq(TimeIdx, :) = Code;
            end
        end
        %-----------------------------------------------------------

        %-----------------------------------------------------------
        %-----------------------------------------------------------
        
    end % end methods

end  % end class
%---------------------------------------------------------------
