% ����r�ķ�Χ
r = 0.1:0.1:10;

% ����10log10r��ֵ
log10r = 10 * log10(r);

% ����ͼ��
plot(r, log10r, 'b.-');
xlabel('r');
ylabel('10log_{10}(r)');
title('Graph of ratio r versus 10log_{10}(r)');
grid on;


% ����r�ķ�Χ
r = 10:1:100;

% ����10log10r��ֵ
log10r = 10 * log10(r);

% ����ͼ��
plot(r, log10r, 'b.-');
xlabel('r');
ylabel('10log_{10}(r)');
title('Graph of ratio r versus 10log_{10}(r)');
grid on;



