% 调频
fs = 1000; % 采样频率
t = 0:1/fs:1; % 时间向量，从0到1秒，每个样本间隔为1/fs
fc = 100; % 载波频率
kf = 50; % 频率偏移系数

% 载波信号
message = sin(2*pi*10*t); % 要调制的信号，这里使用10Hz的正弦波

% 调频信号
phase = 2*pi*cumsum(fc + kf*message)/fs;
modulated_signal = cos(phase);

% 绘制原始信号和调制信号的波形
subplot(2,1,1);
plot(t, message);
xlabel('时间 (秒)');
ylabel('振幅');
title('原始信号');

subplot(2,1,2);
plot(t, modulated_signal);
xlabel('时间 (秒)');
ylabel('振幅');
title('调制信号');


% 解调
demodulated_signal = diff(modulated_signal); % 取差分

% 平方解调相
demodulated_signal = demodulated_signal.^2;

% 滤波
filter_order = 10; % 滤波器阶数
cutoff_freq = 50; % 截止频率
[b, a] = butter(filter_order, cutoff_freq/(fs/2)); % Butterworth低通滤波器设计
demodulated_filter_signal = filter(b, a, demodulated_signal); % 应用滤波器

% 绘制解调信号的波形
figure;
plot(t(2:end), demodulated_filter_signal);
xlabel('时间 (秒)');
ylabel('振幅');
title('解调信号');
