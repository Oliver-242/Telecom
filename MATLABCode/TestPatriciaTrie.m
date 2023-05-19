% TestPatriciaTrie.m
% test the PATRICIA trie structure
%----------------------------------------------------------------

%----------------------------------------------------------------
clear all
close all
%----------------------------------------------------------------

%----------------------------------------------------------------
disp('Select one of the examples in the code below.');
pause
%----------------------------------------------------------------


%----------------------------------------------------------------
hTrie = PatriciaTrie();
%hTrie.Add(02, 'aaa');
%hTrie.Add(06, 'bbb');
%hTrie.Show();
%hTrie.Add('zz');
%hTrie.Add('ccc');

%hTrie.Show();
%----------------------------------------------------------------

%----------------------------------------------------------------
if false
    % note that he gives binary values for keys, 
    % and that in Trie diagrams, matlab numbers bits from 1, not 0, from LSB
    hTrie.Add(1, 'A');
    hTrie.Add(19, 'S');
    hTrie.Add(5, 'E');
    hTrie.Add(18, 'R');
    hTrie.Add(3, 'C');
    hTrie.Add(8, 'H');
    hTrie.Add(9, 'I');
    hTrie.Add(14, 'N');
    hTrie.Add(7, 'G');
    hTrie.Add(24, 'X');
    hTrie.Add(13, 'M');
    hTrie.Add(16, 'P');
    hTrie.Add(12, 'L');
end
%----------------------------------------------------------------

%----------------------------------------------------------------
if false
    % book example 1
    hTrie.Add(04, 'A');
    hTrie.Add(06, 'B');
    hTrie.Add(02, 'C');
    hTrie.Add(09, 'D');
end
%----------------------------------------------------------------

%----------------------------------------------------------------
if false
    % book example 2
    hTrie.Add(18, 'A');
    hTrie.Add(19, 'B');
    hTrie.Add(27, 'x');
    hTrie.Add(8, 'D');
end
%----------------------------------------------------------------

%----------------------------------------------------------------
if false
    % book example 3
    hTrie.Add(34, 'A');
    hTrie.Add(19, 'B');
    %hTrie.Add(27, 'C');
    %hTrie.Add(8, 'D');
end
%----------------------------------------------------------------


%----------------------------------------------------------------
if false
    %fprintf(1, '\nShow: \n');
    %hTrie.Show();

    %fprintf(1, '\nDescend: \n');
    hTrie.Descend();
    %error('a')

    fprintf(1, '\nFind: \n');
    %hTrie.Find(4);
    %hTrie.Find(6);
    %hTrie.Find(2);
    %hTrie.Find(9);

    hTrie.Find(27);
    hTrie.Find(13);
    %hTrie.FindR(27);
end
%----------------------------------------------------------------

%----------------------------------------------------------------
if true
    % trie building example
    hTrie.Add(04, 'A');
    hTrie.Add(06, 'B');
    hTrie.Add(02, 'C');
    hTrie.Add(09, 'D');
    hTrie.Descend();
end
%----------------------------------------------------------------


