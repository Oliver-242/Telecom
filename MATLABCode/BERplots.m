% BERplots.m
% bit error rate calculations and plots
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
SNRbdB = linspace(0, 12, 400);
SNRbAct = 10.^(SNRbdB/10);
Pe = (1/2)*(erfc(sqrt(SNRbAct)));

figure(1);
subplot(1,2,1);
plot(SNRbdB, Pe);
xlabel('Eb/No');
ylabel('Pe');
set(gca, 'yscale', 'log');
grid('on');
grid('minor');
title('Theoretical Curve');
%---------------------------------------------------------------


%---------------------------------------------------------------
N = 1000000;                 % number of bits in simulated channel
SNRbdB = [0:1:12];           % SNR values to test
Ntest = length(SNRbdB);
A = 1;
BERsim = zeros(Ntest, 1);

for snrnum = 1:Ntest
    % desired simulated SNR
    EbNoRatio = 10^(SNRbdB(snrnum)/10);

    % simulated bit stream and data stream
    A = 1;
    tb = randi([0 1], [N, 1]);  % transmitted bit
    td = A*(2*tb - 1);          % transmitted data

    % Gaussian random noise
    g = randn(N, 1);
    varg = var(g);
    EbNoAct = (A^2)/(2*varg);

    % scale noise up so that resulting EbNo is one
    g = g*sqrt(EbNoAct);
    EbNo1 = (A^2)/(2*var(g));
    fprintf(1, 'Scaling EbNo to unity. EbNo1 = %f\n', EbNo1);

    % scale noise down to match desired EbNo
    g = g/sqrt(EbNoRatio);
    EbNo2 = (A^2)/(2*var(g));
    fprintf(1, 'Scaling EbNo to desired. EbNo2 = %f Desired=%f\n', ...
                EbNo2, EbNoRatio);

    % add noise to received data
    rd = td + g;

    % retrieve bitstream from data
    rb = zeros(N, 1);
    i = find( rd >= 0 );
    rb(i) = 1;

    % compare transmitted bitstream with received bitstream
    be = (rb ~= tb);
    ne = length(find(be == 1));
    BERest = ne/N;
    BERsim(snrnum) = BERest;

    BERtheory(snrnum) = 1/2*erfc(sqrt(EbNoRatio));
end

figure(1);
subplot(1,2,2);
plot(SNRbdB, BERsim, 's', SNRbdB, BERtheory, 'd', 'linewidth', 2);
set(gca, 'yscale', 'log');
grid('on');
grid('minor');
xlabel('Eb/No');
ylabel('Pe');
title('Theoretical compared to Simulated');
h = legend('Random Trials', 'Theory');
set(h, 'Location', 'SouthWest');
%---------------------------------------------------------------

