% CommonFactors.m
% Exhaustive search to find factors, and common factors,
% of 1802 and 867
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
for k = 1:867
    rem1 = abs(floor(867/k) - 867/k);
    if( rem1 < eps )
        fprintf(1, '%d is a factor of 867\n', k);
    end
        
    rem2 = abs(floor(1802/k) - 1802/k);
    if( rem1 < eps )
        fprintf(1, '%d is a factor of 1802\n', k);
    end
    
    if( (rem1 < eps) && (rem2 < eps) )
        fprintf(1, '%d is a common factor\n', k);
    end
end
%---------------------------------------------------------------
