% SimpleAM.m
% simple AM wave generation
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
figure(1);
subplot(2,1,1);

% time
N = 2*1024;
Tmax = 10;
dt = Tmax/(N-1);
t = 0:dt:Tmax;

% carrier
Ac = 2;
fc = 4;
wc = 2*pi*fc;
xc = cos(wc*t);

% modulation
Am = 0.5;
fm = 0.5;
wm = 2*pi*fm;
xm = cos(wm*t);

% AM generation
mu = Am/Ac;
xam = Am*xm.*xc + Ac*xc;

plot(t, xam);
xlabel('time s');
ylabel('amplitude');
%---------------------------------------------------------------

%---------------------------------------------------------------
figure(1);
subplot(2,1,2);

% frequency
df = (1/dt);
fam = abs(fft(xam));
fam = fam/N*2;
f = [0:N-1]/N*df;
K = 100;
k = 1:K;
maxfreq = (K/N)*df;

% plot to frequency maxfreq using bars
bar(f(k), fam(k));
axis([0 maxfreq 0 4]);
grid('on');
xlabel('frequency Hz');
ylabel('amplitude');
%---------------------------------------------------------------
