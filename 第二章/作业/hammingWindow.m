function w = hammingWindow(N)
% N: ���ڳ���

w = 0.54 - 0.46*cos(2*pi*(0:N-1)/(N-1));
end


