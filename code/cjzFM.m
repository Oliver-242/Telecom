carrier_freq = 600e3;  % 载波频率
message_freq = 20e3;   % 信息频率
beta = 1;              % 调制指数

fs = 10*carrier_freq;  % 采样率
t = 0:1/fs:1;

message_signal = sin(2*pi*message_freq*t); 
carrier_signal = cos(2*pi*carrier_freq*t); 

% 频率调制
modulated_signal = 0.1*cos(2*pi*carrier_freq*t + beta*message_signal);

% 计算频谱
N = length(modulated_signal);                 % 信号长度
frequencies = (-fs/2):(fs/N):(fs/2)-(fs/N);
spectrum = abs(fftshift(fft(modulated_signal)/N)).^2;  % 幅度谱转换为功率谱

% 取正数频率部分
positive_spectrum = spectrum(int32(N/2)+1:end);
positive_frequencies = frequencies(int32(N/2)+1:end);

% 转换为dBm
dBm_spectrum = 10*log10(1000*positive_spectrum/50);

plot(positive_frequencies, dBm_spectrum);
axis([100000 1000000 -100 0])
xlabel('频率 (Hz)');
ylabel('功率 (dBm)');
title('频谱图');
