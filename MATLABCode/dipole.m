% dipole.m     
% dipole example
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------


%---------------------------------------------------------------
x = -2:0.1:2;
y = -2:0.1:2;
Nx = length(x);
Ny = length(y);

L = 0.1;	% use to simulate a point source
L = 1.0;	% use to simulate a longer antenna

[X, Y] = meshgrid(x, y);
id = find( (X == 0) & ((Y <= L/2) & (Y >= -L/2)) );

omega = 2*pi;
dt = 0.01;
tmax = 4;

lam = 1;
beta = 2*pi/lam;
%---------------------------------------------------------------

%---------------------------------------------------------------
for t = 0:dt:tmax
    Isum = zeros(Ny, Nx);
    Idip = zeros(Ny, Nx);

    for i = 1:length(id)
        xo = X(id(i));
        yo = Y(id(i));

        % cosine current profile
        Io = cos(pi*yo/L);

        % use for Hertzian point dipole with small L
        %Io = 4;

        % save dipole current at this point
        Idip(id(i)) = Io;

        dX = X - xo;
        dY = Y - yo;

        % distance plot from current point
        R = sqrt(dX.^2 + dY.^2);
        theta = atan2(dX, dY);
        I = Io*cos(omega*t - beta*R).*sin(theta);

        % division by zero if R=0, but this is only on the dipole itself
        i = find( abs(R) < eps );
        R(i) = 1;
        I = I./R;
        Isum = Isum + I;
    end

    figure(1);
    set(gcf, 'position', [20 90 450 300]);
    meshc(X, Y, Idip);

    figure(2);
    set(gcf, 'position', [500 90 450 300]);
    IsumDisp = Isum*1 + Idip*40;
    mesh(X, Y, IsumDisp);
    set(gca, 'zlim', [-20 40]);

    figure(3);
    set(gcf, 'position', [1000 90 400 300]);
    IsumDisp = abs(Isum)*10 + Idip*200 + 80;
    image(IsumDisp);
    colormap(parula(255));
    axis('off');
    drawnow
    pause(0.05);
end
%---------------------------------------------------------------
