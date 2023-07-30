N = 100;  % 窗口长度
w = hammingWindow(N);  % 生成汉明窗口

figure;
plot(w);
grid on;
title('Hamming Window');
xlabel('Sample');
ylabel('Amplitude');
