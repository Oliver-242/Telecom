% maxpower.m 
% maximum power transfer
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% parameters of the simulation
Vsrc = 1;
Rsrc = 0.8;

% load resistance range
Rload = linspace(0, 4, 1000);

% equations
Req = Rsrc + Rload;
i = Vsrc./Req;
Pload = (i.*i).*Rload;

% plotting
plot(Rload, Pload);
xlabel('Load Resistance R_{load}')
ylabel('Power Transferred P_{load}')
%---------------------------------------------------------------
