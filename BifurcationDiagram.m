function BifurcationDiagram(fun,y0, paramSpan, plotPhase)
%   Bifurcation draws a bifurcation diagram for a specific system
%   Input:
%   fun is a function handle ODEFUN(T,Y, param)
%   y0 is a vector of initial conditions
%   paramSpan = [P0 P1 ... PFINAL] is a vector of values of param change
%   diagram from different initial conditions
%   Example: Bifurcation(fun, y0, paramSpan)

%% Init params
T = 700; %overall time
h = 0.01; %time step
tspan = 0:h:T; %time span
Tt = 600; %transient time
Nt = ceil(Tt/h); %transient samples
N = length(paramSpan); %len changes param
lenY = length(y0(:,1));%number of initial parameters
colormap lines;
m = colormap;
figBif = FindMaxNumFig();%num fig bifurcation 
figPhase = figBif +1;%num fig phase portrait

figure(figBif);
hold on
xlabel('param'); 
ylabel('x');
%% Main alg
for k = 1:lenY   
    for i = 1:N
        param = paramSpan(i);
        f = @(t,x)fun(t,x,param);
        [y1, y2] = SimulateSystem(f,tspan,y0(k,:),Nt);
  
        peaks = FindPeaks(y1,y2); %% find peaks when y2
        if(~isempty(peaks))
            if(plotPhase)
                figure(figPhase); %plot phase portrait
                plot(y1,y2);
                grid;
                xlabel('$y_1$','interpreter','latex'); 
                ylabel('$y_2$','interpreter','latex');
                set(gca,'TickLabelInterpreter','latex'); 
            end
            v = param*ones(length(peaks),1); %surrogate span of w
            figure(figBif);
            plot(v,peaks,'.k','MarkerSize',3, 'Color',m(k,:)); %plot black dots of crossing 0 by y2
            hold on
            drawnow
        end
    end
end