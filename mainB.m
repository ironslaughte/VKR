%start Case B
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
y0 = [-3, -2, -2]; %initial cond
Y0 = [y0; 3, 2, -2];
pspan = 5.8:h:5.92;
%% Solve system whith param = 1
f = @(t,y0)caseB(t,y0,1);
[t,Y] = ode45(f,tspan,Y0(1,:)'); %solve system
numFig = FindMaxNumFig();
PlotPhase(Y,Nt,numFig);

%% Bifurcation
%Bifurcation(@caseB,Y0,pspan, true); %plot bifurcation diagram on which the values of x from the change of parameter b
%% Find multistability for system B
%FindAttractors(@caseB,[-50,50],[-50,50],[-50,50],100, 5.92, true);
%% Basisns of attraction
tic
%BasinsOfAttraction(@caseB,[-5,5],[-5,5],0.01,2.5);
toc
%end case B