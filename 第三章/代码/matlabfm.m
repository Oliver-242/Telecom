% 调频
fs = 1000; % 采样频率
t = 0:1/fs:1; % 时间向量，从0到1秒，每个样本间隔为1/fs
fc = 100; % 载波频率
kf = 50; % 频率偏移系数

% 调制信号
message = sin(2*pi*10*t); % 要调制的信号，这里使用10Hz的正弦波
modulated_signal = fmmod(message, fc, fs, kf); % 调频

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
demodulated_signal = fmdemod(modulated_signal, fc, fs, kf); % 解调

% 绘制解调信号的波形
figure;
plot(t, demodulated_signal);
xlabel('时间 (秒)');
ylabel('振幅');
title('解调信号');
