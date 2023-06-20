% ��Ƶ
fs = 1000; % ����Ƶ��
t = 0:1/fs:1; % ʱ����������0��1�룬ÿ���������Ϊ1/fs
fc = 100; % �ز�Ƶ��
kf = 50; % Ƶ��ƫ��ϵ��

% �����ź�
message = sin(2*pi*10*t); % Ҫ���Ƶ��źţ�����ʹ��10Hz�����Ҳ�
modulated_signal = fmmod(message, fc, fs, kf); % ��Ƶ

% ����ԭʼ�źź͵����źŵĲ���
subplot(2,1,1);
plot(t, message);
xlabel('ʱ�� (��)');
ylabel('���');
title('ԭʼ�ź�');

subplot(2,1,2);
plot(t, modulated_signal);
xlabel('ʱ�� (��)');
ylabel('���');
title('�����ź�');

% ���
demodulated_signal = fmdemod(modulated_signal, fc, fs, kf); % ���

% ���ƽ���źŵĲ���
figure;
plot(t, demodulated_signal);
xlabel('ʱ�� (��)');
ylabel('���');
title('����ź�');
