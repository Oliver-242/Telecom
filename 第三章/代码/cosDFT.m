% 创建余弦信号 y(n)，其中一个周期的长度为32
N = 64;
T_cos = 32;
n = 0:N-1;
y = cos(2*pi*n/T_cos);

% 计算傅里叶变换
Y = fft(y);

% 提取频域复数值的实部和虚部
Y_real = real(Y);
Y_imag = imag(Y);

% 绘制时域信号的波形图
subplot(3, 1, 1);
stem(n, y, 'g', 'MarkerFaceColor', 'g');
title('Time Domain Signal (Cosine)');
xlabel('Sample Index (n)');
ylabel('Amplitude');

% 绘制实部频域图
subplot(3, 1, 2);
stem(n, Y_real, 'm', 'MarkerFaceColor', 'm');
title('Real Part of Frequency Domain (Cosine)');
xlabel('Frequency Index (k)');
ylabel('Magnitude');

% 绘制虚部频域图
subplot(3,1,3)
stem(n, Y_imag, 'm', 'MarkerFaceColor', 'm');
title('Imag Part of Frequency Domain (Cosine)');
xlabel('Frequency Index (k)');
ylabel('Magnitude');

% 调整图形窗口标题
sgtitle('Cosine Signal and Its Fourier Transform');
