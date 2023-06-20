n = 0:10;
beta = [0,0.25,0.5,1,1.5,2,2.4,2.5,3,4,5,6,7,8,9,10,12,15];
coefficients = zeros(length(beta), length(n));

for i = 1:length(beta)
    for j = 1:length(n)
        x = besselj(n(j), beta(i));
        if abs(x) < 0.01
            coefficients(i,j) = 0;
        else
            coefficients(i,j) = round(x,2);
        end
    end
end

% 绘制表格
figure;
uitable('Data', coefficients, 'ColumnName', n, 'RowName', beta,'Position', [0, 0, 1000, 500]);