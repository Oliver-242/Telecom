% WaveAddition.m
% addition of waves of various phases
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
t = 0:pi/100:10*pi;
%phi = 0;
%phi = pi/2;
%phi = 3*pi/4;
phi = pi;

x = sin(t);
x1 = sin(t + phi);

y = x + x1;

subplot(3,1,1);
plot(t, x, 'linewidth', 2);
axis('off');
set(gca, 'ylim', [-2.2 2.2]);
title('Direct Waveform');

subplot(3,1,2);
plot(t, x1, 'linewidth', 2);
axis('off');
set(gca, 'ylim', [-2.2 2.2]);
title('Delayed Waveform');

subplot(3,1,3);
plot(t, y, 'linewidth', 2);
axis('off');
set(gca, 'ylim', [-2.2 2.2]);
title('Addition of Waveforms');
%---------------------------------------------------------------
