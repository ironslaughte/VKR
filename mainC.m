%start Case C
%% Includes folders
addpath('Systems');
addpath('Utils');
addpath('Simulation');
addpath('Clusters'); 
%% Initialization params system
h = 0.01; %time step
tspan = 0:h:600; %time span
Tt = 400; %transient time
Nt = ceil(Tt/h); %transient samples
y0 = [-3, 2, 0]; %initial cond
Y0 = [y0; 3, -2, 0];
%% Initializing a system parameter change
dp = 0.05;%parameter change step
pspan = 7:dp:12; %parameter span
%% Solve system whith params = -2
f = @(t,y0)caseC(t,y0, 9.85);
[t,Y] = RK4(f,tspan,Y0(1,:)'); %solve system
PlotPhase(Y,Nt,1);
[t,Y] = RK4(f,tspan,Y0(2,:)'); %solve system
PlotPhase(Y,Nt,1);
%% Bifurcation
%Bifurcation(@caseC,Y0,pspan, true); %plot bifurcation diagram on which the values of x from the change of parameter b
%% Find multistability for system C
%FindAttractors(@caseC,[-10,10],[-10,10],[0, 0], 50, 0.5, true);
%% Basisns of attraction
BasinsOfAttraction(@caseC,[-5,5],[-5,5],0.1,9.85);

%end case C