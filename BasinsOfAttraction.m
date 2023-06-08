function BasinsOfAttraction(fun,xSection,ySection,step,paramVal)
%   BasinsOfAttraction displays attraction pools for a specific system
%   Input:
%   fun is a function handle ODEFUN(T,Y, param)
%   xSection is a vector containing the minimum and maximum values of X 
%   ySection is a vector containing the minimum and maximum values of Y 
%   step - the step of changing X and Y
%   paramVal Passed to the fun(T,Y, param)
%   Example: BasinsOfAttraction(@Lorenz, [-10,10], [-15,15], 0.1, 2)
%% Init params
T = 150; %overall time
h = 0.01; %time step
tspan = 0:h:T; %time span
Tt = 100; %transient time
Nt = ceil(Tt/h); %transient samples
f = @(t,x)fun(t,x, paramVal);
x = xSection(1):step:xSection(2);
y = ySection(1):step:ySection(2);
[X,Y] = meshgrid(x,y);
idxAttractors = zeros(length(x),length(x));
%% Find attractors
% [Attractors, numAttractors] = FindAttractors(fun, ...
%     [xSection(1) - 45,xSection(2) + 45],[ySection(1) - 45,ySection(2) + 45],...
%     [0,0],50,paramVal,true);
[Attractors, numAttractors] = FindAttractors(fun, ...
    [-50,50],[-50,50],...
    [0,0],100,paramVal,true);
%% Main alg
for i = 1:length(x)
    for j = 1:length(x)
        [y1, y2, y3]= SimulateSystem(f,tspan,[X(i,j),Y(i,j),0],Nt);
        if(length(y1) > 3)
            [peaksy3, idx] = FindPeaks(y3,y2);
            if(~isempty(peaksy3))
                peaksy1 = y1(idx);
                peaksy2 = y2(idx);
                Peaks = [];
                Peaks = cat(1,Peaks,[peaksy1, peaksy2, peaksy3]);
                minDist = realmax;
                for k=1:length(numAttractors)
                    numAttractor = Attractors(Attractors(:,4) == k,1:3);
                    diff = pdist2(Peaks,numAttractor);
                    [m,~] = min(diff);
                    m = min(m);
                    if(m < minDist)
                        minDist = m;
                        idxAttractors(i,j) = k;
                    end
                end
            end
        end
     end
end
figBasins = FindMaxNumFig(); 
figure(figBasins);
hold on;
contourf(X,Y,idxAttractors, 'LineWidth',0.1,"FaceAlpha",0.5);
title('Basins of attraction');
xlabel('x');
ylabel('y');
drawnow;
end