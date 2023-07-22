clear;
clc;

T  = 10;
N = 2*1024;
dt = T/(N-1);
t  = 0:dt:T;
df = 1/dt;
fs = 100;
k = 1:fs;
f = [0:N-1]/N*df;

Am = 1.2;
Ac = 2;

mt = Am*cos(pi/3*t);
xc = Ac*cos(10*pi/3*t);
pro = mt .* xc;
am = xc + mt.*cos(10*pi/3*t);
x = abs(fft(am, N));
x = x/N*2;



subplot(4,1,1)
    plot(t,mt);
    grid on;
    title('m(t)')
subplot(4,1,2)
    plot(t,xc)
        grid on;
    title('Xc(t)')
subplot(4,1,3)
    plot(t,pro, LineWidth=1);
    grid on;
    title('m(t) × Xc(t)')
subplot(4,1,4)
    plot(t,mt+Ac)
    hold on;
    plot(t, -mt-Ac)
    hold on;
    plot(t, am)
    title('AM')


    
