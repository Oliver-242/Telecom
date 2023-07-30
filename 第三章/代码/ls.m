syms t s

% 冲激响应函数 h(t)，这里假设 h(t) = e^(-2t) * u(t)，其中 u(t) 是单位阶跃函数
h_t = exp(-2*t);

% 拉氏变换函数 H(s)
H_s = laplace(h_t, t, s);

% 显示结果
disp('冲激响应函数 h(t) = ')
disp(h_t)
disp('拉氏变换函数 H(s) = ')
disp(H_s)
