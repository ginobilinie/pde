%This scripts is used to call the cubicspline function, and supply the
%needed input data or parameter.
numofpoints=[5,10,15,20,25];
dy0=0.01479;%boundary condition: first derivative at left boudary point
dyN=-0.01479;%boundary condition: first derivative at right boudary point
dy=[dy0,dyN];
x0=linspace(-5,5,20);%these points are to fit the interpolation polynomial
accuracydigits=4;%means 4 digits after 0.
for i=1:length(numofpoints)
    n=numofpoints(i);
    x=linspace(-5,5,n);
    y=f(x);
    figure;
    cubicSpline(x,y,dy,x0,accuracydigits);
    title([['This figure is made up of ',num2str(n)],' interpolation points']);
end
