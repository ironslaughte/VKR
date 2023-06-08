%start Lorenz
%% Includes folders
addpath('Systems');
addpath('Utils');
addpath('Simulation');
addpath('Clusters'); 
%% Initialization params system
h = 0.01; %time step
tspan = 0:h:300; %time span
Tt = 150; %transient time
Nt = ceil(Tt/h); %transient samples
y0 = [5, 5, 5]; %initial cond
Y0 = [y0, 0.1, 0.1, 0];
%% Initializing a system parameter change
dp = 0.001;%parameter change step
pspan = 1.8:dp:2.1; %parameter span
%% Solve system whith param = 2
f1 = @(t,x)Lorenz(t,x,2);
[t,a] = RK4(f1 ,tspan,y0'); %solve system
PlotPhase(a,Nt,1);
%% Bifurcation
%Bifurcation(@Lorenz,Y0,pspan, true); %plot bifurcation diagram on which the values of x from the change of parameter b
%% Find multistability for Lorenz system 
%FindAttractors(@Lorenz,[-50,50],[-50,50],[-50,50],100,2, true);
%% Basisns of attraction
tic
BasinsOfAttraction2(@Lorenz,[-5,5],[-5,5],0.1,2);
toc

%End Lorenz