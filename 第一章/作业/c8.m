% 定义r的范围
r = 0.1:0.1:10;

% 计算10log10r的值
log10r = 10 * log10(r);

% 绘制图形
plot(r, log10r, 'b.-');
xlabel('r');
ylabel('10log_{10}(r)');
title('Graph of ratio r versus 10log_{10}(r)');
grid on;


% 定义r的范围
r = 10:1:100;

% 计算10log10r的值
log10r = 10 * log10(r);

% 绘制图形
plot(r, log10r, 'b.-');
xlabel('r');
ylabel('10log_{10}(r)');
title('Graph of ratio r versus 10log_{10}(r)');
grid on;



