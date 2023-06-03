% TestFourierSpectrum.m
% calls CalcFourierSpectrum to show spectra
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% TestFourierSpectrum.m
% Test waveforms for CalcFourierSpectrum.m
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

% TestFourierSpectrum.m
% Test waveforms for CalcFourierSpectrum.m
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
dt = 0.001;
tmax = 4;
t = 0:dt:tmax;
%---------------------------------------------------------------

%---------------------------------------------------------------
% setup the continuous-time signal we want to analyze
%---------------------------------------------------------------

%---------------------------------------------------------------
% case 1 - single sine wave
if( true )
    f = 3.5;
    xt = sin(2*pi*f*t);
    xt = 1.2*sin(2*pi*f*t);
end
%---------------------------------------------------------------

%---------------------------------------------------------------
% case 2 - two sine waves
if( false )
    f1 = 3.5;
    f2 = 5;
    xt = 1.2*sin(2*pi*f1*t) + 0.8*cos(2*pi*f2*t) + 0;
end
%---------------------------------------------------------------

%---------------------------------------------------------------
% case 3 - sinc wave
if( false )
    tau = 0.1;
    td = 2;
    t = 0:dt:tmax;
    xt = sin(pi*(t-td)/tau + eps)./(pi*(t-td)/tau + eps);
    
    %figure(1);
    %clf
    %plot(t, xt);
    %pause
end
%---------------------------------------------------------------

%---------------------------------------------------------------
fmax = 10;
[Xm,  fvec] = CalcFourierSpectrum(xt, tmax, fmax, false);
[Xmw, fvec, xtw] = CalcFourierSpectrum(xt, tmax, fmax, true);
%---------------------------------------------------------------

%---------------------------------------------------------------
figure(1);
clf
subplot(2,2,1);
plot(t, xt, 'linewidth', 2);

grid('on');
grid('minor');
h = xlabel('Time - seconds');
set(h, 'interpreter', 'latex');
title('waveform');
set(gca, 'ylim', [-1.2 1.2]);
set(gca, 'ylim', [-0.5 1.2]);
%set(gca, 'ylim', [-1.5 1.5]);
set(gca, 'ylim', [-2.2 2.2]);
%set(gca, 'ytick', [0:0.5:1]);
%set(gca, 'PlotBoxAspectRatio', [1 .4 1])

subplot(2,2,2);
plot(fvec, Xm, 'linewidth', 2);
grid('on');
grid('minor');
h = xlabel('Frequency - Hz');
title('spectrum');
set(h, 'interpreter', 'latex');
set(gca, 'PlotBoxAspectRatio', [1 .4 1])
set(gca, 'xlim', [0 fmax]);
set(gca, 'ylim', [-0.2 1.6]);
%set(gca, 'ylim', [-0.01 0.055]);
%set(gca, 'ylim', [-0.2 2]);

subplot(2,2,3);
plot(t, xtw, 'linewidth', 2);
grid('on');
grid('minor');
h = xlabel('Time - seconds');
set(h, 'interpreter', 'latex');
title('waveform');
set(gca, 'ylim', [-1.2 1.2]);
set(gca, 'ylim', [-0.5 1.2]);
set(gca, 'ylim', [-2.2 2.2]);
%set(gca, 'ylim', [-1.5 1.5]);
%set(gca, 'ytick', [0:0.5:1]);
set(gca, 'PlotBoxAspectRatio', [1 .4 1])

subplot(2,2,4);
plot(fvec, Xmw, 'linewidth', 2);
grid('on');
grid('minor');
h = xlabel('Frequency - Hz');
set(h, 'interpreter', 'latex');
title('spectrum');
set(gca, 'PlotBoxAspectRatio', [1 .4 1])
set(gca, 'xlim', [0 fmax]);
set(gca, 'ylim', [-0.2 1.6]);
%---------------------------------------------------------------
