%x0:initial guess
%
function root= Steffensen(f,x0,eps)
iter=0;
g0=(f(x0+f(x0))-f(x0))/f(x0);
x1=x0-f(x0)/g0;
fprintf('iter=%d\t\troot=%g\n',iter,x1)
while abs(x1-x0)>eps&&f(x1)>eps
    x0=x1;
    g0=(f(x0+f(x0))-f(x0))/f(x0);
    x1=x0-f(x0)/g0;
    iter=iter+1;
    fprintf('iter=%d\t\troot=%g\t\tdiv=%g\n',iter,x1,abs(x1-x0))
end
root=x1;
end