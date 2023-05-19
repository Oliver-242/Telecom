% expmod.m
% exponentiation modulo N
% rv = a^ev mod N
% ev may be a scalar or a vector
%---------------------------------------------------------------

%---------------------------------------------------------------
function [rv] = expmod(a, ev, N)

% loop caters for exponent ev being a vector
rv = zeros(length(ev), 1);
for k = 1:length(ev)

    e = ev(k);

    % exponentiation with modulo at each stage- does not overflow
    r = 1;
    for nn = 1:e
        r = mod(r*a, N);
    end
    r = mod(r, N);

    % save in case vector result
    rv(k) = r;
end
%---------------------------------------------------------------
