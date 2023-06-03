% mdct.m
% modified DCT 
% 2N inputs, N outputs
%---------------------------------------------------------------

%---------------------------------------------------------------
function [X] = mdct(x)

    x = x(:);

    %N2 = length(x);
    %N = round(N2/2);

    M = length(x);
    N = round(M/2);

    X = zeros(N, 1);
    for k = 0:N-1
        s = 0;
        for n = 0:2*N-1 % M-1
            % these are equivalent  
            %s = s + x(n+1)*cos( (pi/N)*(n + 1/2 + N/2)*(k + 1/2) );
            s = s + x(n+1)*cos( (pi/(2*M))*(2*n + 1 + N)*(2*k + 1) );
        end
        X(k+1) = s;
    end
end
%---------------------------------------------------------------
