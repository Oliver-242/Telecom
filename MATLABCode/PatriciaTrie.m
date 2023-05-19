% PatriciaTrie.m     
% PATRICIA trie object declaration
%---------------------------------------------------------------

%---------------------------------------------------------------
% class for the entire trie,
% which is comprised of individual trie nodes
classdef PatriciaTrie < handle

    properties (SetAccess = private)
        % the root node itself
        RootNode

        %maxbits = 8+1;   % for uint8 bitmask
        % should be one more than the number of bits required in each node
        % as this will be stored in the root node
        maxbits = 6;     % for examples
    end

    methods

      % constructor
      function Trie =  PatriciaTrie()
          fprintf(1, 'Create Patricia Trie\n');

          b = Trie.maxbits;
          Key = 0;
          Name = 'Root';

          Trie.RootNode = PatriciaTrieNode(Key, Name, b);
        end
        %---------------------------------------------------------------

        %---------------------------------------------------------------
        %
        % insert other methods here:
        %
        % Descend()
        %
        % Find()
        %
        %---------------------------------------------------------------
        
        %---------------------------------------------------------------
        % descend the trie by recursion, showing each visited node's contents
        function Descend(Trie, CurrNode)
            disp('Descend Trie');

            % Note that nargin will be 1 if called with no arguments, since
            % methods are called with the first argument being the object itself.
            if( nargin == 1 )
                CurrNode = Trie.RootNode;
            end

            if( isempty(CurrNode) )
                fprintf(1, 'Trie is empty\n');
                return;
            end

            % show visited node name and info
            CurrNode.ShowNode();

            % descend left
            if( CurrNode.b > CurrNode.Left.b )
                fprintf(1, 'Descend Left\n');

                Descend(Trie, CurrNode.Left);
            end

            % descend right
            if( CurrNode.b > CurrNode.Right.b )
                fprintf(1, 'Descend Right\n');

                Descend(Trie, CurrNode.Right);
            end
        end
        %---------------------------------------------------------------

        %---------------------------------------------------------------
        % find a given key in the trie
        function Find(Trie, Key)
            p = Trie.RootNode;             % p = parent node
            c = Trie.RootNode.Left;        % c = child node
            while( p.b > c.b )
                p = c;
                if( bitget(Key, c.b) )
                    c = c.Right;
                else
                    c = c.Left;
                end
            end

            if( c.Key == Key )
                fprintf(1, 'Exact match found (value %d)\n', Key);
            else
                fprintf(1, 'Exact failed (requested %d, closest %d )\n', Key, c.Key);
            end
            fprintf(1, 'Name=%s  Key=%d\n', c.Name, c.Key);
        end
        %---------------------------------------------------------------

        %---------------------------------------------------------------
        function Add(Trie, Key, Name)
            % descend to level where there is a back-pointer
            p = Trie.RootNode;             % p = parent node
            c = Trie.RootNode.Left;        % c = child node
            while( p.b > c.b )
                p = c;
                if( bitget(Key, c.b) )
                    c = c.Right;
                else
                    c = c.Left;
                end
            end

            % check for a direct match
            if( c.Key == Key )
                return;
            end

            % find smallest bit index where current node and new node differ
            i = Trie.maxbits;
            while( bitget(c.Key, i) == bitget(Key, i) )
                i = i - 1;
            end
            b = i;
            fprintf(1, 'smallest difference bit index %d\n', b);

            % re-descend until this level or we find the correct insertion point
            p = Trie.RootNode;
            c = Trie.RootNode.Left;
            while( (p.b > c.b) && (c.b > b) )
                p = c;
                if( bitget(Key, c.b) == 1 )
                    c = c.Right;
                else
                    c = c.Left;
                end
            end

            % create the new node
            NewNode =  PatriciaTrieNode(Key, Name, b);

            % set pointers in new node (default is self-pointer)
            if( bitget(Key, b) == 1 )
                NewNode.Left = c;       % default: NewNode.Right = NewNode;
            else
                NewNode.Right = c;      % default: NewNode.Left = NewNode;
            end

            % set pointer to new node in parent
            if( bitget(Key, p.b) == 1 )
                p.Right = NewNode;
            else
                p.Left = NewNode;
            end
        end
        %---------------------------------------------------------------

    end  % end methods
    %---------------------------------------------------------------
end
%---------------------------------------------------------------
