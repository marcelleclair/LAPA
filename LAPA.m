set(0, 'DefaultFigureWindowStyle', 'docked');
close all

% solution matrix dimensions
nx = 30;
ny = 30;
n_itter = 0;
n_itter_max = 1000;
% Initial guess zero potential everywhere
V = zeros(ny,nx);

V(1,:) = 0;
V(ny,:) = 0;
V(:,1) = 1; % left
V(:,nx) = 1; % right
Vp = V; % previous voltage matrix to check convergance
delta = ones(ny,nx);
delta_prime = 1e-3;

figure(1);
ax_V = gca;

figure(2);
ax_E = gca;


while(any(any(delta > delta_prime)) && n_itter < n_itter_max)
    V(2:ny-1,2:nx-1) = (V(1:ny-2,2:nx-1) + V(3:ny,2:nx-1)...
        + V(2:ny-1,1:nx-2) + V(2:ny-1,3:nx))/4;
    % apply free BC at top and bottom
%     V(1,:) = V(2,:); % top
%     V(ny,:) = V(ny-1,:); % bottom
    delta = V - Vp;
    [Ex, Ey] = gradient(V);
    surf(ax_V,V);
    title(ax_V,"Electric Potential");
    xlabel(ax_V,'x');
    ylabel(ax_V,'y');
    zlabel(ax_V,'V');
    view([1 -1 1])
    quiver(ax_E,Ex,Ey)
    title(ax_E,"Electric Field");
    xlabel(ax_E,'x');
    ylabel(ax_E,'y');
    pause(0.017);
    % present becomes past
    n_itter = n_itter + 1;
    Vp = V;
    fprintf("Itteration #%d\n", n_itter);
end