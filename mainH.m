%start Case H
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
y0 = [0.5, 0.5, 1]; %initial cond
Y0 = [y0; 1.3, 1.3, 0];
%% Initializing a system parameter change
dp = 0.005;%parameter change step
pspan = 1:dp:3; %parameter span
%% Solve system whith param = 1
f = @(t,y0)caseH(t,y0, 1);
[t,Y] = RK4(f,tspan,Y0(1,:)'); %solve system
PlotPhase(Y,Nt,1);
%% Solve system whith param = 1.5
%% Bifurcation
%Bifurcation(@caseH,Y0,pspan, true); %plot bifurcation diagram on which the values of x from the change of parameter b
%% Find multistability for system B
%FindAttractors(@caseH,[0.1,1.4],[0.1,1.4],[0.1,1],50,2.1, true);
%% Lyapunov exponents
%BasinsOfAttraction(@caseH,[-5,5],[-5,5],0.1,2.1);

%end case H