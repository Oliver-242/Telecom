% DCTexamp.m 
% DCT example
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
N = 4;            % block size

X = rand(N, N);	  % input block
Y = zeros(N, N);  % output block

% each output coefficient
for k = 0:N-1
    for el = 0:N-1

        % calculate one DCT coefficient
        s = 0;
        for n = 0:N-1
            for m = 0:N-1
                s = s + X(m+1, n+1)*...
                          cos( (2*m+1)*k*pi/(2*N) ) * ...
                          cos( (2*n+1)*el*pi/(2*N) );
            end
        end

        if( k == 0 )
            ck = 1/sqrt(2);
        else
            ck = 1;
        end

        if( el == 0 )
            cl = 1/sqrt(2);
        else
            cl = 1;
        end

        Y(k+1, el+1) = 2/N*ck*cl*s;
    end
end

disp('Input X');
disp(X);

disp('Y = DCT(X)');
disp(Y);
%---------------------------------------------------------------
