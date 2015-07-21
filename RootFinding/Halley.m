function y=Halley(f,x0,eps)
iter=0;
x1=x0-2*f(x0)*fDeriv(x0)/((2*fDeriv(x0))^2-f(x0)*fDeriv2(x0));
fprintf('iter=%d\t\troot=%g\n',iter,x1)
while (abs(x1-x0)>eps&&abs(f(x1))>eps) 
    x0=x1;
    x1=x0-2*f(x0)*fDeriv(x0)/((2*fDeriv(x0))^2-f(x0)*fDeriv2(x0));
    iter=iter+1;
    fprintf('iter=%d\t\troot=%g\t\tdiv=%g\n',iter,x1,abs(x1-x0))

end
y=x1;
return

function y=fDeriv(x)
y=1-cos(x);
return

function y=fDeriv2(x)
y=sin(x);
return