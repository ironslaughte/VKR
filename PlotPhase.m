function PlotPhase(Y, Nt, numFig)
figure(numFig);
hold on;
plot3(Y(Nt:end,1),Y(Nt:end,2),Y(Nt:end,3)); %plot 3D phase portrait
xlabel('x');
ylabel('y');
zlabel('z');
end