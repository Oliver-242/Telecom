clear all;
clc;

figure(1);
subplot(2,1,1);

fc = 2;
fm = 0.2;
beta = 5;
% delta_w = 6.28;

N = 2*1024;
Tmax = 10;
dt = Tmax/(N-1);
t = 0:dt:Tmax;

signalc = cos(2*pi*fc*t);
signalm = sin(2*pi*fm*t);

modulated = cos(2*pi*fc*t+beta*signalm);

plot(t, modulated);
axis([0 10 -2 2]);
xlabel('time s');
ylabel('amplitude');

figure(1);
subplot(2,1,2);

fs = 1/dt;
ffm = abs(fft(modulated));
ffm = ffm/N*2;
f = [0:N-1]/N*fs;
K = 100;
k = 1:K;
maxfreq = (K/N)*fs;

bar(f(k), ffm(k));
axis([0 maxfreq 0 0.5]);
grid('on');
xlabel('frequency Hz');
ylabel('amplitude');