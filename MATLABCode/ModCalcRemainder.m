% ModCalcRemainder.m   
% modulo calculation remainders 
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
a = 5;
N = 23;
sort(mod(a.^[1:N-1], N))

a = 5;
N = 23;
sort(expmod(a, [1:N-1], N))'

a = 6;
N = 22;
sort(mod(a.^[1:N-1], N))

a = 6;
N = 23;
sort(mod(a.^[1:N-1], N))
%---------------------------------------------------------------

