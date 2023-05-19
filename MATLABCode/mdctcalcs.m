% mdctcalcs.m 
% Modified DCT and inverse MDCT calculation examples.
% The mdct and imdct functions are generic for any length, 
% but the example below shows a 4-point block with 2-point outputs. 
%---------------------------------------------------------------

%---------------------------------------------------------------
close all
clear all
%---------------------------------------------------------------

%---------------------------------------------------------------
% input vector
x = [6 8 7 4 9 2 3  7 1 4];
disp(x);

% partition input vector into 4-sample overlapping blocks 
x1 = x(1:4);
x2 = x(3:6);
x3 = x(5:8);
x4 = x(7:10);

disp(x1); 
disp(x2); 
disp(x3); 
disp(x4); 

% take MDCT of each of these blocks 4->2 
X1 = mdct(x1);
X2 = mdct(x2);
X3 = mdct(x3);
X4 = mdct(x4);

% take inverse MDCT of each transformed block 2->4 
y1 = imdct(X1);
y2 = imdct(X2);
y3 = imdct(X3);
y4 = imdct(X4);

disp(y1'); 
disp(y2'); 
disp(y3'); 
disp(y4'); 

% combine output blocks with overlap
y = zeros(1, length(x));

y(1:2) = y1(1:2)';    % will not be correct 
y(3:4) = y1(3:4)' + y2(1:2)';
y(5:6) = y2(3:4)' + y3(1:2)';
y(7:8) = y3(3:4)' + y4(1:2)';
y(9:10) = y4(3:4);    % will also not be correct
%---------------------------------------------------------------

