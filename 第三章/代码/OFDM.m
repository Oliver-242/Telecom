% OFDM 模拟程序示例

clear all;
close all;

%% 参数设置

% 子载波总数
N = 64;

% 基带数据长度
data_len = N / 2;

% 调制阶数
QAM_order = 16; % 可以尝试使用不同的QAM阶数，例如QAM_order = 4, 16, 64等

% 高斯白噪声功率
noise_power = 0.01;

% 循环前缀长度
CP_len = 16;

%% 生成随机基带数据
data_bits = randi([0, 1], data_len, 1);

%% 调制

% 使用QAM调制将数据映射到复平面
QAM_symbols = qammod(data_bits, QAM_order);

% 添加零值，形成复数符号向量
QAM_symbols_complex = [QAM_symbols; zeros(data_len, 1)];

%% IFFT

% 将复数符号向量进行IFFT变换
time_domain_signal = ifft(QAM_symbols_complex);

% 增加循环前缀
cyclic_prefix = time_domain_signal(end - CP_len + 1:end);
time_domain_signal_with_cp = [cyclic_prefix; time_domain_signal];

%% 信道（这里简化为加性高斯白噪声信道）

% 创建高斯白噪声
noise = sqrt(noise_power/2) * (randn(N+CP_len, 1) + 1j * randn(N+CP_len, 1));

% 信道输出信号
channel_output = time_domain_signal_with_cp + noise;

%% 移除循环前缀

received_signal = channel_output(CP_len+1:end);

%% FFT

% 进行FFT变换得到频域信号
received_frequency_domain = fft(received_signal);

%% 调制解调

% 提取接收到的复数符号（忽略零值）
received_symbols_complex = received_frequency_domain(1:data_len);

% 使用QAM解调
received_bits = qamdemod(received_symbols_complex, QAM_order);

%% 比特错误率计算

bit_error_rate = sum(data_bits ~= received_bits) / data_len;
disp(['Bit Error Rate: ', num2str(bit_error_rate)]);

%% 绘图

figure;

% 绘制发送信号时域波形
subplot(3, 1, 1);
plot(real(time_domain_signal_with_cp), 'b');
hold on;
plot(imag(time_domain_signal_with_cp), 'r');
title('Time Domain OFDM Signal (With Cyclic Prefix)');
xlabel('Sample Index');
ylabel('Amplitude');
legend('Real Part', 'Imaginary Part');
hold off;

% 绘制接收信号时域波形
subplot(3, 1, 2);
plot(real(received_signal), 'b');
hold on;
plot(imag(received_signal), 'r');
title('Time Domain OFDM Signal (Received)');
xlabel('Sample Index');
ylabel('Amplitude');
legend('Real Part', 'Imaginary Part');
hold off;

% 绘制接收信号星座图
subplot(3, 1, 3);
scatter(real(received_symbols_complex), imag(received_symbols_complex), 'bo');
title('Received Constellation');
xlabel('In-Phase (I)');
ylabel('Quadrature (Q)');

sgtitle('OFDM Simulation Example');
