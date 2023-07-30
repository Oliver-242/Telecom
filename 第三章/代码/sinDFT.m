% 创建正弦信号 x(n)，其中一个周期的长度为16
N = 64;
T = 16;
n = 0:N-1;
x = sin(2*pi*n/T);

% 计算傅里叶变换
X = fft(x);

% 提取频域复数值的实部和虚部
X_real = real(X);
X_imag = imag(X);

% 绘制时域信号的波形图
subplot(3, 1, 1);
stem(n, x, 'b', 'MarkerFaceColor', 'b');
title('Time Domain Signal (Sinusoidal)');
xlabel('Sample Index (n)');
ylabel('Amplitude');

% 绘制实部频域图
subplot(3, 1, 2);
stem(n, X_real, 'r', 'MarkerFaceColor', 'r');
title('Real Part of Frequency Domain (Sinusoidal)');
xlabel('Frequency Index (k)');
ylabel('Magnitude');

% 绘制虚部频域图
subplot(3, 1, 3);
stem(n, X_imag, 'r', 'MarkerFaceColor', 'r');
title('Imag Part of Frequency Domain (Sinusoidal)');
xlabel('Frequency Index (k)');
ylabel('Magnitude');

% 调整图形窗口标题
sgtitle('Sinusoidal Signal and Its Fourier Transform');
