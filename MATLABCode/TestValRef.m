% TestValRef.m 
% testing by-value and by-reference (handle) declared objects
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% by value
var1 = IntValue(7);     % assign
var2 = var1;            % copy
var2.TheValue = 999;    % overwrite

% check original and copied value
fprintf(1, 'By value: var1=%d  var2=%d\n', var1.TheValue, var2.TheValue);
%---------------------------------------------------------------

%---------------------------------------------------------------
% by reference
var3 = IntHandle(8);    % assign
var4 = var3;            % copy
var4.TheValue = 888;    % overwrite

% check original and copied value
fprintf(1, 'By reference: var3=%d  var4=%d\n', var3.TheValue, var4.TheValue);
%---------------------------------------------------------------
