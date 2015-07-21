%x0:initial guess
%
function root= Steffensen(f,x0,eps)
g0=(f(x0+f(x0))-f(x0))/f(x0);
x1=x0-f(x0)/g0;
while abs(x1-x0)>eps&&f(x1)>eps
    x0=x1;
    g0=(f(x0+f(x0))-f(x0))/f(x0);
    x1=x0-f(x0)/g0;
end
root=x1;
end