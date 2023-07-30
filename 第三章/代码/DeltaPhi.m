clear;
clc;

beta = 1.2;                 % beta should not equal 1

fin = 10;                   % Hz
fvco= beta*fin;             % Hz

T  = 2.5;                      % sec.
dt = T/(max(fin,fvco)*200);
t  = 0:dt:T;

dPhi = 2*pi*(fvco-fin) * t;

l = floor(abs((fvco-fin) * T)); 
index = zeros(1,l);

for i = 1:l
    index(i) = find(abs(abs(dPhi)-2*i*pi)<abs(2*pi*(fvco-fin) * dt),1);
    fprintf('should be %d*2pi : %f \n',i,dPhi(index(i))/(2*pi));
    %fprintf('%f \n',dPhi(index(i)));
end

dPhiNew = zeros(1,length(t));
dPhiNew(1:index(1)-1) = dPhi(1:index(1)-1);
if beta < 1
    for j = 1:(l-1)
        dPhiNew(index(j):index(j+1)-1) = dPhi(index(j):index(j+1)-1) + 2*j*pi;
    end

else
    for j = 1:(l-1)
        dPhiNew(index(j):index(j+1)-1) = dPhi(index(j):index(j+1)-1) - 2*j*pi;
    end
end





%index = find(abs(abs(dPhi)-2*pi)<abs(2*pi*(fvco-fin) * dt),1)


% if beta < 1
%     % fvco < fin, each adds a 2pi angle
% 
% 
% else
%     % fvco >= fin
% 
% end
% 
subplot(3,1,1)
    plot(t,dPhi, LineWidth=1);
    grid on;
    title('--Phi over time--')
subplot(3,1,2)
    plot(t,sin(2*pi*fin*t),t,sin(2*pi*fvco*t),LineWidth = 1);
    grid on;
    hold on;
    plot(t(index),sin(dPhi(index)),'ok', LineWidth=2)
    title('--DataIn vs. VCO--')
subplot(3,1,3)
    plot(t,dPhiNew, LineWidth=1);
    grid on;
    title('--Phi over time--')
    
