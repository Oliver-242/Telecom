% PatriciaTrieNode.m
% node object declaration for PATRICIA trie
%---------------------------------------------------------------

%---------------------------------------------------------------
% class for nodes within the trie
classdef PatriciaTrieNode < handle

    properties (SetAccess = private)
        Key         % the binary key for this node
        Name        % identifying name for this node
        b           % index of bit to test for this node
    end

    properties
        Left        % left pointer, branch if 0
        Right       % right pointer, branch if 1
    end

    methods

      % constructor
      function node =  PatriciaTrieNode(Key, Name, b)
          node.Key = uint8(Key);
          node.Name = Name;
          node.b = b;

          % initialize to self-pointers, not null
          node.Left = node;
          node.Right = node;
      end

      % display the contents of a node
      function ShowNode(TheNode)
          fprintf(1, 'PatriciaTrieNode Name="%s"  Key=%d  b=%d\n', ...
              TheNode.Name, TheNode.Key, TheNode.b);

          if( ~isempty(TheNode.Left) )
              fprintf(1, 'Left pointer -> %s\n', TheNode.Left.Name);
          else
              disp('Left pointer is null');
          end

          if( ~isempty(TheNode.Right) )
              fprintf(1, 'Right pointer -> %s\n', TheNode.Right.Name);
          else
              disp('Right pointer is null');
          end

      end

    end % end methods
end
%---------------------------------------------------------------
