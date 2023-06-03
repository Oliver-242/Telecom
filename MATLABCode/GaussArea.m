% GaussArea.m
% area under a Gaussian curve and the erfc function
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
N = 400;                      % number of points
x = linspace(-4, 4, N);       % uniformly spaced points over the range
dx = x(2) - x(1);             % delta x

v = 1;                        % variance
m = 0;                        % mean

% Gaussian function
g = (1/sqrt(2*pi*v))*exp( -(x-m).^2/(2*v) );

plot(x, g);
fprintf(1, 'total area = %f\n', sum(g.*dx));

% find the area greater than u
u = 1.2;
i = min(find(x >= u));
area = sum(g(i:end).*dx);
fprintf(1, 'area under tail from u = %f\n', area);
%---------------------------------------------------------------

%---------------------------------------------------------------
fprintf(1, 'calculating 0.5*erfc(0/sqrt(2)) = %f\n', 0.5*erfc(0/sqrt(2)));
fprintf(1, 'calculating 0.5*erfc(1.2/sqrt(2)) = %f\n', 0.5*erfc(1.2/sqrt(2)));
%---------------------------------------------------------------




%---------------------------------------------------------------
